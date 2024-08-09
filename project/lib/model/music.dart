import 'dart:typed_data';

class Music {
  final int? id;
  final String nome;
  final String autor;
  final Uint8List capa;
  final String nomearquivo;

  Music(
      {this.id,
      required this.nome,
      required this.autor,
      required this.capa,
      required this.nomearquivo});

  Map<String, Object?> toMap() {
    return {
      'nome': nome,
      'autor': autor,
      'capa': capa,
      'nomearquivo': nomearquivo
    };
  }

  @override
  String toString() {
    return 'Music: {Nome: $nome, Autor: $autor, Capa: $capa, Nome Arquivo: $nomearquivo}';
  }
}
