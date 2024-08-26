import 'dart:typed_data';

class Usuario {
  final int? id;
  final String nome;
  final String senha;
  final String email;
  final Uint8List? foto;

  Usuario(
      {this.id,
      required this.nome,
      required this.senha,
      required this.email,
      this.foto});

  Map<String, Object?> toMap() {
    return {'nome': nome, 'senha': senha, 'email': email};
  }

  @override
  String toString() {
    return 'Music: {Nome: $nome, Senha: $senha, Email: $email}';
  }
}
