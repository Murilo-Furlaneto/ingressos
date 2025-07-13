
import 'package:ingressos/features/movie/domain/entities/cast_entity.dart';
import 'package:ingressos/features/movie/domain/repository/movies_repository.dart';

class GetMovieCast {
  final MoviesRepository repository;

  GetMovieCast({required this.repository});

    Future<List<Cast>> getMovieCast(int movieId) async {
      return await repository.getMovieCast(movieId);
    }

}