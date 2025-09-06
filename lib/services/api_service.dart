import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/tipo_usuario.dart';
import '../models/usuario.dart';

class ApiService {
  static const String baseUrl = Config.apiBaseUrl;

  // Métodos para Tipos de Usuário
  static Future<List<TipoUsuario>> getTiposUsuarios() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tipos-usuarios'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => TipoUsuario.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar tipos de usuários: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar com a API: $e');
    }
  }

  static Future<TipoUsuario> createTipoUsuario(String descricao) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tipos-usuarios'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'descricao': descricao}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return TipoUsuario.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao criar tipo de usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao criar tipo de usuário: $e');
    }
  }

  static Future<TipoUsuario> updateTipoUsuario(int id, String descricao) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/tipos-usuarios/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'descricao': descricao}),
      );

      if (response.statusCode == 200) {
        return TipoUsuario.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao atualizar tipo de usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar tipo de usuário: $e');
    }
  }

  static Future<void> deleteTipoUsuario(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/tipos-usuarios/$id'));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Falha ao deletar tipo de usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao deletar tipo de usuário: $e');
    }
  }

  // Métodos para Usuários
  static Future<List<Usuario>> getUsuarios() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/usuarios'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Usuario.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar usuários: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar com a API: $e');
    }
  }

  static Future<Usuario> createUsuario({
    required String nome,
    required String telefone,
    required String email,
    required int tipoDeProfissional,
    required bool situacao,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/usuarios'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nome': nome,
          'telefone': telefone,
          'email': email,
          'tipoDeProfissional': tipoDeProfissional,
          'situacao': situacao,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Usuario.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao criar usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao criar usuário: $e');
    }
  }

  static Future<Usuario> updateUsuario({
    required int id,
    required String nome,
    required String telefone,
    required String email,
    required int tipoDeProfissional,
    required bool situacao,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/usuarios/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nome': nome,
          'telefone': telefone,
          'email': email,
          'tipoDeProfissional': tipoDeProfissional,
          'situacao': situacao,
        }),
      );

      if (response.statusCode == 200) {
        return Usuario.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao atualizar usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar usuário: $e');
    }
  }

  static Future<void> deleteUsuario(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/usuarios/$id'));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Falha ao deletar usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao deletar usuário: $e');
    }
  }

  // Método para Login de Administrador
  static Future<Map<String, dynamic>> loginAdmin({
    required String email,
    required String password,
  }) async {
    // Lista de formatos para tentar
    final List<Map<String, dynamic>> requestFormats = [
      {'username': email, 'password': password},
      {'email': email, 'password': password},
      {'login': email, 'password': password},
      {'user': email, 'password': password},
    ];

    for (int i = 0; i < requestFormats.length; i++) {
      try {
        final requestBody = requestFormats[i];
        
        print('🔍 Debug Login - Tentativa ${i + 1}');
        print('🔍 Debug Login - URL: $baseUrl/admins/login');
        print('🔍 Debug Login - Body: ${json.encode(requestBody)}');
        
        final response = await http.post(
          Uri.parse('$baseUrl/admins/login'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );
        
        print('🔍 Debug Login - Status: ${response.statusCode}');
        print('🔍 Debug Login - Response: ${response.body}');

        if (response.statusCode == 200) {
          return json.decode(response.body);
        } else if (response.statusCode == 401) {
          throw Exception('Email ou senha incorretos');
        } else if (response.statusCode == 400) {
          // Se for erro 400, tentar próximo formato
          print('🔍 Debug Login - Erro 400, tentando próximo formato...');
          continue;
        } else {
          throw Exception('Falha no login: ${response.statusCode} - ${response.body}');
        }
      } catch (e) {
        print('🔍 Debug Login - Erro na tentativa ${i + 1}: $e');
        if (i == requestFormats.length - 1) {
          // Última tentativa, relançar o erro
          if (e.toString().contains('Exception:')) {
            rethrow;
          }
          throw Exception('Erro ao fazer login: $e');
        }
        // Continuar para próxima tentativa
        continue;
      }
    }
    
    // Se chegou aqui, todas as tentativas falharam
    throw Exception('Email ou senha incorretos');
  }
}
