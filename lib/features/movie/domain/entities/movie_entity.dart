class Movie {
  final int id;
  final String titulo;
  final String posterPath;
  final String backdropPath;
  final List<int> generoIds;
  final String sinopse;
  final String dataLancamento;
  final double notaMedia;
  final int quantidadeVotos;
  final bool adulto;
  final String idiomaOriginal;
  final double popularidade;

  Movie({
    required this.id,
    required this.titulo,
    required this.posterPath,
    required this.backdropPath,
    required this.generoIds,
    required this.sinopse,
    required this.dataLancamento,
    required this.notaMedia,
    required this.quantidadeVotos,
    required this.adulto,
    required this.idiomaOriginal,
    required this.popularidade,
  });
}