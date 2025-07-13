import 'package:ingressos/features/movie/domain/entities/genre_entity.dart';

class MovieDetail {
  final int id;
  final int runtime;
  final List<Genre> genres;

  MovieDetail({
    required this.id,
    required this.runtime,
    required this.genres,
  });

}