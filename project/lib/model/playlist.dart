import 'dart:typed_data';

class Playlist {
  final int? id;
  final String nome;
  final Uint8List capa;

  Playlist({this.id, required this.nome, required this.capa});

  Map<String, Object?> toMap() {
    return {'nome': nome, 'capa': capa};
  }

  @override
  String toString() {
    return 'Music: {Nome: $nome, Capa: $capa}';
  }
}
