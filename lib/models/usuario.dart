class Usuario {
  final int? id;
  final String nome;
  final String telefone;
  final String email;
  final int tipoDeProfissional;
  final bool situacao;

  Usuario({
    this.id,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.tipoDeProfissional,
    required this.situacao,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      telefone: json['telefone'],
      email: json['email'],
      tipoDeProfissional: json['tipoDeProfissional'],
      situacao: json['situacao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'tipoDeProfissional': tipoDeProfissional,
      'situacao': situacao,
    };
  }

  Usuario copyWith({
    int? id,
    String? nome,
    String? telefone,
    String? email,
    int? tipoDeProfissional,
    bool? situacao,
  }) {
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
      tipoDeProfissional: tipoDeProfissional ?? this.tipoDeProfissional,
      situacao: situacao ?? this.situacao,
    );
  }
}
