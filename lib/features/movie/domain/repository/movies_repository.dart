import 'dart:core';
import 'package:ingressos/features/movie/domain/entities/cast_entity.dart';
import 'package:ingressos/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/movie/domain/entities/review_entity.dart';
import 'package:ingressos/features/movie/domain/entities/video_entity.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying();
  Future<List<Movie>> getUpComing();
  Future<MovieDetail> getMovieDetail(int movieId);
  Future<List<Video>> getMovieVideos(int movieId);
  Future<List<Cast>> getMovieCast(int movieId);
  Future<List<Review>> getMovieReviews(int movieId);
}
