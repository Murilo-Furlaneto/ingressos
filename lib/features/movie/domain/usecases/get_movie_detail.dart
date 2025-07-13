
import 'package:ingressos/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:ingressos/features/movie/domain/repository/movies_repository.dart';

class GetMovieDetail {
  final MoviesRepository repository;

  GetMovieDetail({required this.repository});

  Future<MovieDetail> getMovieDetail (int movieId) async{
    return await repository.getMovieDetail(movieId);
  }
}