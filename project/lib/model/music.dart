class Music {
  final int? id;
  final String nome;
  final String autor;

  Music({this.id, required this.nome, required this.autor});

  Map<String, Object?> toMap() {
    return {'nome': nome, 'autor': autor};
  }

  @override
  String toString() {
    return 'Music: {Nome: $nome, Autor: $autor}';
  }
}
