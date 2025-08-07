import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';

class MovieModel {
  final int id;
  final String title;
  final String posterPath;
  final String? backdropPath; 
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
    this.backdropPath, // Não obrigatório
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
      id: json['id'] ?? 0, // Valor padrão caso falte no JSON
      title: json['title'] ?? 'Sem título', // Valor padrão
      posterPath: json['poster_path'] ?? '', // Valor padrão
      backdropPath: json['backdrop_path'], // Pode ser nulo
      genreIds: List<int>.from(json['genre_ids'] ?? []), // Garantindo que a lista nunca seja nula
      overview: json['overview'] ?? '', // Valor padrão
      releaseDate: json['release_date'] ?? 'Data desconhecida', // Valor padrão
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0, // Valor padrão
      voteCount: json['vote_count'] ?? 0, // Valor padrão
      adult: json['adult'] ?? false, // Valor padrão
      originalLanguage: json['original_language'] ?? 'en', // Valor padrão
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0, // Valor padrão
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
      titulo: model.title,
      posterPath: model.posterPath,
      backdropPath: model.backdropPath ?? '', 
      generoIds: model.genreIds,
      sinopse: model.overview,
      dataLancamento: model.releaseDate,
      notaMedia: model.voteAverage,
      quantidadeVotos: model.voteCount,
      adulto: model.adult,
      idiomaOriginal: model.originalLanguage,
      popularidade: model.popularity,
    );
  }

  static MovieModel toModel(Movie movie) {
    return MovieModel(
      id: movie.id,
      title: movie.titulo,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath, 
      genreIds: movie.generoIds,
      overview: movie.sinopse,
      releaseDate: movie.dataLancamento,
      voteAverage: movie.notaMedia,
      voteCount: movie.quantidadeVotos,
      adult: movie.adulto,
      originalLanguage: movie.idiomaOriginal,
      popularity: movie.popularidade,
    );
  }
}
