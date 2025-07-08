import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';

class MovieModel {
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

  MovieModel({
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

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids']),
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
      adult: json['adult'],
      originalLanguage: json['original_language'],
      popularity: (json['popularity'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'overview': overview,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'adult': adult,
      'original_language': originalLanguage,
      'popularity': popularity,
    };
  }

  static Movie toEntity(MovieModel model) {
    return Movie(
      id: model.id,
      title: model.title,
      posterPath: model.posterPath,
      backdropPath: model.backdropPath,
      genreIds: model.genreIds,
      overview: model.overview,
      releaseDate: model.releaseDate,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
      adult: model.adult,
      originalLanguage: model.originalLanguage,
      popularity: model.popularity,
    );
  }

  static MovieModel toModel(Movie movie) {
    return MovieModel(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      genreIds: movie.genreIds,
      overview: movie.overview,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
      adult: movie.adult,
      originalLanguage: movie.originalLanguage,
      popularity: movie.popularity,
    );
  }
}
