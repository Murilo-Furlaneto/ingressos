import 'package:flutter/material.dart';
import 'package:ingressos/features/movie/domain/entities/cast_entity.dart';
import 'package:ingressos/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/movie/domain/entities/review_entity.dart';
import 'package:ingressos/features/movie/domain/entities/video_entity.dart';
import 'package:ingressos/features/movie/domain/usecases/get_movie_cast.dart';
import 'package:ingressos/features/movie/domain/usecases/get_movie_detail.dart';
import 'package:ingressos/features/movie/domain/usecases/get_movie_reviews.dart';
import 'package:ingressos/features/movie/domain/usecases/get_movie_videos.dart';
import 'package:ingressos/features/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ingressos/features/movie/domain/usecases/get_up_coming.dart';

class MovieNotifier {
  MovieNotifier({    
    required this.getNowPlayingUseCase,
    required this.getUpComingUseCase,
    required this.getMovieCastUseCase,
    required this.getMovieDetailUseCase,
    required this.getMovieReviewsUseCase, 
    required this.getMovieVideosUseCase,
});

final GetNowPlayingMovies getNowPlayingUseCase;
  final GetUpComingMovies getUpComingUseCase;
  final GetMovieDetail getMovieDetailUseCase;
  final GetMovieVideos getMovieVideosUseCase;
  final GetMovieCast getMovieCastUseCase;
  final GetMovieReviews getMovieReviewsUseCase;

    final ValueNotifier<List<Movie>> nowPlayingMovies = ValueNotifier<List<Movie>>([]);

  final ValueNotifier<List<Movie>> comingSoonMovies =  ValueNotifier<List<Movie>>([]);

Future<List<Movie>> getNowPlaying() async {
    nowPlayingMovies.value = List.from(await getNowPlayingUseCase.getMovies());
    return nowPlayingMovies.value;
  }

  Future<List<Movie>> getUpComing() async {
    comingSoonMovies.value = List.from(await getUpComingUseCase.getUpComing());
    return comingSoonMovies.value;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    return await getMovieCastUseCase.getMovieCast(movieId);
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    return await getMovieDetailUseCase.getMovieDetail(movieId);
  }

  Future<List<Review>> getMovieReviews(int movieId) async {
    return await getMovieReviewsUseCase.getMovieReviews(movieId);
  }

  Future<List<Video>> getMovieVideos(int movieId) async {
    return await getMovieVideosUseCase.getMovieVideos(movieId);
  }
}
