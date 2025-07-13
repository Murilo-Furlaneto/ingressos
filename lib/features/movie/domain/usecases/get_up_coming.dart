
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/movie/domain/repository/movies_repository.dart';

class GetUpComingMovies {
  final MoviesRepository repository;

  GetUpComingMovies({required this.repository});

  Future<List<Movie>> getUpComing () async{
    return await repository.getUpComing();
  }
}