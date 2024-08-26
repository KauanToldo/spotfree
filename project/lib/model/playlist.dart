class Playlist {
  final int? id;
  final String nome;
  final String capa;

  Playlist({this.id, required this.nome, required this.capa});

  Map<String, Object?> toMap() {
    return {'nome': nome, 'capa': capa};
  }

  @override
  String toString() {
    return 'Music: {Nome: $nome, Capa: $capa}';
  }
}
