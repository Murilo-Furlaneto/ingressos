
import 'package:ingressos/features/movie/domain/entities/video_entity.dart';
import 'package:ingressos/features/movie/domain/repository/movies_repository.dart';

class GetMovieVideos {
  final MoviesRepository repository;

  GetMovieVideos({required this.repository});

Future<List<Video>> getMovieVideos(int movieId)async{
  return await repository.getMovieVideos(movieId);
}

}