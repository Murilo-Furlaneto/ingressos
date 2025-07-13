
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/movie/domain/repository/movies_repository.dart';

class GetNowPlayingMovies {
  final MoviesRepository repository;

  GetNowPlayingMovies({required this.repository});

  Future<List<Movie>> getMovies () async{
    return await repository.getNowPlaying();
  }
}