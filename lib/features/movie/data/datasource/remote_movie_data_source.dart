import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:ingressos/core/error/network/network_failure.dart';
import 'package:ingressos/features/movie/data/model/cast_model.dart';
import 'package:ingressos/features/movie/data/model/movie_detail_model.dart';
import 'package:ingressos/features/movie/data/model/movie_model.dart';
import 'package:ingressos/features/movie/data/model/review_model.dart';
import 'package:ingressos/features/movie/data/model/video_model.dart';

class RemoteMovieDataSource {
  final http.Client client;

  final _baererToken = dotenv.get('TMDB_KEY');

  RemoteMovieDataSource({required this.client});

  Future<Either<NetworkFailure, List<MovieModel>>> getNowPlaying() async {
    try {
      final response = await client.get(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/now_playing?language=pt-BR&region=BR",
        ),
        headers: {'Authorization': 'Bearer $_baererToken'},
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['results'] != null) {
          final results =
              (decoded['results'] as List)
                  .map((item) => MovieModel.fromJson(item))
                  .toList();
          return right(results);
        } else {
          return left(
            NetworkFailure(
              description: 'Resposta vazia: ${response.statusCode}',
            ),
          );
        }
      } else {
        return left(
          NetworkFailure(
            description:
                'Erro ao buscar filmes em cartaz: ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
      return left(NetworkFailure.fromException(e));
    }
  }

  Future<Either<NetworkFailure, List<MovieModel>>> getUpComing() async {
    try {
      final response = await client.get(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/upcoming?language=pt-BR&region=BR",
        ),
        headers: {'Authorization': 'Bearer $_baererToken'},
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final results =
            (decoded['results'] as List)
                .map((item) => MovieModel.fromJson(item))
                .toList();

        return right(results);
      } else {
        return left(
          NetworkFailure(
            description:
                'Erro ao buscar próximos lançamentos: ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
      return left(NetworkFailure.fromException(e));
    }
  }

  Future<Either<NetworkFailure, MovieDetailModel>> getMovieDetail(
    int movieId,
  ) async {
    try {
      final response = await client.get(
        Uri.parse("https://api.themoviedb.org/3/movie/$movieId?language=pt-BR"),
        headers: {'Authorization': 'Bearer $_baererToken'},
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return right(MovieDetailModel.fromJson(decoded));
      } else {
        return left(
          NetworkFailure(
            description:
                'Erro ao buscar detalhes do filme: ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
      return left(NetworkFailure.fromException(e));
    }
  }

  Future<Either<NetworkFailure, List<VideoModel>>> getMovieVideos(
    int movieId,
  ) async {
    try {
      final response = await client.get(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/videos?language=pt-BR",
        ),
        headers: {'Authorization': 'Bearer $_baererToken'},
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final results =
            (decoded['results'] as List)
                .map((item) => VideoModel.fromJson(item))
                .toList();
        return right(results);
      } else {
        return left(
          NetworkFailure(
            description:
                'Erro ao buscar vídeos do filme: ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
      return left(NetworkFailure.fromException(e));
    }
  }

  Future<Either<NetworkFailure, List<CastModel>>> getMovieCast(
    int movieId,
  ) async {
    try {
      final response = await client.get(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/credits?language=pt-BR",
        ),
        headers: {'Authorization': 'Bearer $_baererToken'},
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final castList =
            (decoded['cast'] as List)
                .map((item) => CastModel.fromJson(item))
                .toList();
        return right(castList);
      } else {
        return left(
          NetworkFailure(
            description:
                'Erro ao buscar elenco do filme: ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
      return left(NetworkFailure.fromException(e));
    }
  }

  Future<Either<NetworkFailure, List<ReviewModel>>> getMovieReviews(
    int movieId,
  ) async {
    try {
      final response = await client.get(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/reviews?language=pt-BR",
        ),
        headers: {'Authorization': 'Bearer $_baererToken'},
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final reviews =
            (decoded['results'] as List)
                .map((item) => ReviewModel.fromJson(item))
                .toList();
        return right(reviews);
      } else {
        return left(
          NetworkFailure(
            description:
                'Erro ao buscar avaliações do filme: ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
      return left(NetworkFailure.fromException(e));
    }
  }
}
