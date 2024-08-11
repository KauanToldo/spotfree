class Usuario {
  final int? id;
  final String nome;
  final String senha;
  final String email;

  Usuario(
      {this.id, required this.nome, required this.senha, required this.email});

  Map<String, Object?> toMap() {
    return {'nome': nome, 'senha': senha, 'email': email};
  }

  @override
  String toString() {
    return 'Music: {Nome: $nome, Senha: $senha, Email: $email}';
  }
}
