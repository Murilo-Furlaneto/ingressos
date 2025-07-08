import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:ingressos/core/error/network/network_failure.dart';
import 'package:ingressos/features/movie/data/model/movie_model.dart';

class RemoteMovieDataSource {
  final http.Client client;

  RemoteMovieDataSource({required this.client});

  Future<Either<NetworkFailure, MovieModel>> getNowPlaying() async {
    try {
      final response = await client.get(
        Uri.parse("https://api.themoviedb.org/3/movie/now_playing?language=pt-BR&region=BR"),
        headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNmYwNWIzYzFmYTBiMjFjMTFjNjUxZWNhZjY2NDdmZCIsIm5iZiI6MTY0Mzc1ODMzNS4wNzMsInN1YiI6IjYxZjljMmZmNmYzMWFmMDA0NDdhNjA4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DGzmd6GXXws0o7aQFf29iJDTVe1rSAFkA1HQY2zpink'
        },
      );
      if (response.statusCode == 200) {
         return right(MovieModel.fromJson(jsonDecode(response.body)));
      } else {
        return left(NetworkFailure(description: 'Erro ao buscar filmes em cartaz: ${response.statusCode}'),);
      }
    } on Exception catch (e) {
      return left(NetworkFailure.fromException(e));
    }
  }

  Future<Either<NetworkFailure,MovieModel>> getUpComing() async {
    try {
      final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/upcoming?language=pt-BR=BR"), headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNmYwNWIzYzFmYTBiMjFjMTFjNjUxZWNhZjY2NDdmZCIsIm5iZiI6MTY0Mzc1ODMzNS4wNzMsInN1YiI6IjYxZjljMmZmNmYzMWFmMDA0NDdhNjA4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DGzmd6GXXws0o7aQFf29iJDTVe1rSAFkA1HQY2zpink'
        },);

        if(response.statusCode == 200){
          return right(MovieModel.fromJson(jsonDecode(response.body)));
        } else{
          return left(NetworkFailure(description: 'Erro ao buscar filmes que serão lançados em breve: ${response.statusCode}'),);
        }
    } on Exception catch (e) {
      return left(NetworkFailure.fromException(e));
    }
  }
}