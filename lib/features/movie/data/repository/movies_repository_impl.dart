
import 'package:ingressos/features/movie/data/datasource/remote_movie_data_source.dart';
import 'package:ingressos/features/movie/data/model/movie_model.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/movie/domain/repository/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository{
  final RemoteMovieDataSource remoteMovieDataSource;

  MoviesRepositoryImpl({required this.remoteMovieDataSource});

 @override
Future<Movie> getNowPlaying() async {
  final eitherResult = await remoteMovieDataSource.getNowPlaying();

  return eitherResult.fold(
    (failure) => throw Exception('Erro ao buscar filme: $failure'),
    (model) => MovieModel.toEntity(model),
  );
}

  @override
  Future<Movie> getUpComing() async {
    final eitherResult = await remoteMovieDataSource.getUpComing();

    return eitherResult.fold((failure) => throw Exception("Erro ao buscar os filmes que serão lançados em breve"), 
    (model) => MovieModel.toEntity(model));
  }
   
}