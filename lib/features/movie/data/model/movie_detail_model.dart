import 'package:ingressos/features/movie/data/model/genre_model.dart';
import 'package:ingressos/features/movie/domain/entities/genre_entity.dart';
import 'package:ingressos/features/movie/domain/entities/movie_detail_entity.dart';

class MovieDetailModel {
  final int id;
  final int runtime;
  final List<Genre> genres;

  MovieDetailModel({
    required this.id,
    required this.runtime,
    required this.genres,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List)
          .map((g) => GenreModel.toEntity(GenreModel.fromJson(g)))
          .toList(),
    );
  }

  static MovieDetail toEntity(MovieDetailModel model){
    return MovieDetail(id: model.id, runtime: model.runtime, genres: model.genres);
  }
}