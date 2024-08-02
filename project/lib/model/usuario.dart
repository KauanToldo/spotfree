class Usuario {
  final int? id;
  final String nome;
  final String senha;

  Usuario({this.id, required this.nome, required this.senha});

  Map<String, Object?> toMap() {
    return {'nome': nome, 'senha': senha};
  }

  @override
  String toString() {
    return 'Music: {Nome: $nome, Senha: $senha}';
  }
}
