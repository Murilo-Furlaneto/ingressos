import 'package:ingressos/features/movie/data/datasource/remote_movie_data_source.dart';
import 'package:ingressos/features/movie/data/model/cast_model.dart';
import 'package:ingressos/features/movie/data/model/movie_detail_model.dart';
import 'package:ingressos/features/movie/data/model/movie_model.dart';
import 'package:ingressos/features/movie/data/model/review_model.dart';
import 'package:ingressos/features/movie/data/model/video_model.dart';
import 'package:ingressos/features/movie/domain/entities/cast_entity.dart';
import 'package:ingressos/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/movie/domain/entities/review_entity.dart';
import 'package:ingressos/features/movie/domain/entities/video_entity.dart';
import 'package:ingressos/features/movie/domain/repository/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final RemoteMovieDataSource remoteMovieDataSource;

  List<Movie>? _cachedNowPlaying;
  List<Movie>? _cachedUpComing;

  MoviesRepositoryImpl({required this.remoteMovieDataSource});

  @override
  Future<List<Movie>> getNowPlaying() async {
    if (_cachedNowPlaying != null) return _cachedNowPlaying!;

    final eitherResult = await remoteMovieDataSource.getNowPlaying();

    return eitherResult.fold(
      (failure) => throw Exception('Erro ao buscar filme: $failure'),
      (model) {
        _cachedNowPlaying = model.map((e) => MovieModel.toEntity(e)).toList();
        return _cachedNowPlaying!;
      },
    );
  }

  @override
  Future<List<Movie>> getUpComing() async {
    if (_cachedUpComing != null) return _cachedUpComing!;

    final eitherResult = await remoteMovieDataSource.getUpComing();

    return eitherResult.fold(
      (failure) =>
          throw Exception(
            "Erro ao buscar os filmes que serão lançados em breve",
          ),
      (model) {
        _cachedUpComing = model.map((e) => MovieModel.toEntity(e)).toList();
        return _cachedUpComing!;
      },
    );
  }

  @override
  Future<List<Cast>> getMovieCast(int movieId) async {
    final eitherResult = await remoteMovieDataSource.getMovieCast(movieId);

    return eitherResult.fold(
      (failure) => throw Exception('Erro ao buscar elenco do filme: $failure'),
      (models) {
        return models.map((e) => CastModel.toEntity(e)).toList();
      },
    );
  }

  @override
  Future<MovieDetail> getMovieDetail(int movieId) async {
    final eitherResult = await remoteMovieDataSource.getMovieDetail(movieId);

    return eitherResult.fold(
      (failure) =>
          throw Exception('Erro ao buscar detalhes do filme: $failure'),
      (model) => MovieDetailModel.toEntity(model),
    );
  }

  @override
  Future<List<Review>> getMovieReviews(int movieId) async {
    final eitherResult = await remoteMovieDataSource.getMovieReviews(movieId);

    return eitherResult.fold(
      (failure) =>
          throw Exception('Erro ao buscar avaliações do filme: $failure'),
      (models) {
        return models.map((e) => ReviewModel.toEntity(e)).toList();
      },
    );
  }

  @override
  Future<List<Video>> getMovieVideos(int movieId) async {
    final eitherResult = await remoteMovieDataSource.getMovieVideos(movieId);

    return eitherResult.fold(
      (failure) => throw Exception('Erro ao buscar vídeos do filme: $failure'),
      (models) {
        return models.map((e) => VideoModel.toEntity(e)).toList();
      },
    );
  }
}
