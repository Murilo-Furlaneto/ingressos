class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final List<int> genreIds;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final bool adult;
  final String originalLanguage;
  final double popularity;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.genreIds,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
    required this.originalLanguage,
    required this.popularity,
  });
}
