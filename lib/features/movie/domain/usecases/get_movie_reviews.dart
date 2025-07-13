import 'package:ingressos/features/movie/domain/entities/review_entity.dart';
import 'package:ingressos/features/movie/domain/repository/movies_repository.dart';

class GetMovieReviews {
  final MoviesRepository repository;

  GetMovieReviews({required this.repository});

  Future<List<Review>> getMovieReviews(int movieId) async {
    return await repository.getMovieReviews(movieId);
  }
}
