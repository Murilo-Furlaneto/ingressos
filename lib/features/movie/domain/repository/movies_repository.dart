import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<Movie> getNowPlaying();

  Future<Movie> getUpComing();
}