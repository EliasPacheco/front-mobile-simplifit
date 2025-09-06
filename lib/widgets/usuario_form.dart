import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/usuario.dart';
import '../models/tipo_usuario.dart';
import '../services/api_service.dart';

class UsuarioForm extends StatefulWidget {
  final Usuario? usuario;
  final List<TipoUsuario> tiposUsuarios;
  final VoidCallback onSaved;

  const UsuarioForm({
    super.key,
    this.usuario,
    required this.tiposUsuarios,
    required this.onSaved,
  });

  @override
  State<UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  
  int? _selectedTipoId;
  bool _situacao = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.usuario != null) {
      _nomeController.text = widget.usuario!.nome;
      _telefoneController.text = widget.usuario!.telefone;
      _emailController.text = widget.usuario!.email;
      _selectedTipoId = widget.usuario!.tipoDeProfissional;
      _situacao = widget.usuario!.situacao;
    } else if (widget.tiposUsuarios.isNotEmpty) {
      _selectedTipoId = widget.tiposUsuarios.first.id;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedTipoId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione um tipo de usuário')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.usuario == null) {
        // Criar novo usuário
        await ApiService.createUsuario(
          nome: _nomeController.text.trim(),
          telefone: _telefoneController.text.trim(),
          email: _emailController.text.trim(),
          tipoDeProfissional: _selectedTipoId!,
          situacao: _situacao,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário criado com sucesso!'), backgroundColor: Colors.green,),
          );
        }
      } else {
        // Atualizar usuário existente
        await ApiService.updateUsuario(
          id: widget.usuario!.id!,
          nome: _nomeController.text.trim(),
          telefone: _telefoneController.text.trim(),
          email: _emailController.text.trim(),
          tipoDeProfissional: _selectedTipoId!,
          situacao: _situacao,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário atualizado com sucesso!'), backgroundColor: Colors.green,),
          );
        }
      }
      widget.onSaved();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira um email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }

  String? _validateTelefone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, insira um telefone';
    }
    // Remove caracteres não numéricos para validação
    final cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanPhone.length < 10) {
      return 'Por favor, insira um telefone válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.usuario == null ? 'Novo Usuário' : 'Editar Usuário'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: '(11) 99999-9999',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                validator: _validateTelefone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedTipoId,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Profissional',
                  border: OutlineInputBorder(),
                ),
                items: widget.tiposUsuarios.map((tipo) {
                  return DropdownMenuItem<int>(
                    value: tipo.id,
                    child: Text(tipo.descricao),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTipoId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione um tipo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Situação'),
                subtitle: Text(_situacao ? 'Ativo' : 'Inativo'),
                value: _situacao,
                onChanged: (value) {
                  setState(() {
                    _situacao = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _save,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(widget.usuario == null ? 'Criar' : 'Salvar'),
        ),
      ],
    );
  }
}
