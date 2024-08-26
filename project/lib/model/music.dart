class Music {
  final int? id;
  final String nome;
  final String autor;
  final String capa;
  final String nomearquivo;
  final int tamanho;

  Music(
      {this.id,
      required this.nome,
      required this.autor,
      required this.capa,
      required this.nomearquivo,
      required this.tamanho});

  Map<String, Object?> toMap() {
    return {
      'nome': nome,
      'autor': autor,
      'capa': capa,
      'nomearquivo': nomearquivo,
      'tamanho': tamanho
    };
  }

  @override
  String toString() {
    return 'Music: {Nome: $nome, Autor: $autor, Capa: $capa, Nome Arquivo: $nomearquivo, Tamanho: $tamanho segundos}';
  }
}
