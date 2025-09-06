class TipoUsuario {
  final int? id;
  final String descricao;

  TipoUsuario({
    this.id,
    required this.descricao,
  });

  factory TipoUsuario.fromJson(Map<String, dynamic> json) {
    return TipoUsuario(
      id: json['id'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
    };
  }

  TipoUsuario copyWith({
    int? id,
    String? descricao,
  }) {
    return TipoUsuario(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
    );
  }
}
