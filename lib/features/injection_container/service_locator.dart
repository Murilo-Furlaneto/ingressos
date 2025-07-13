import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ingressos/features/movie/data/datasource/remote_movie_data_source.dart';
import 'package:ingressos/features/movie/data/repository/movies_repository_impl.dart';
import 'package:ingressos/features/movie/domain/repository/movies_repository.dart';
import 'package:ingressos/features/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ingressos/features/movie/domain/usecases/get_up_coming.dart';
import 'package:ingressos/features/movie/presenter/provider/movie_notifier.dart';

final get = GetIt.instance;

void setupLocator() {
  // External dependencies
  get.registerLazySingleton(() => http.Client());

  // DataSources
  get.registerLazySingleton<RemoteMovieDataSource>(
    () => RemoteMovieDataSource(client: get()),
  );

  // Repository
  get.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(remoteMovieDataSource: get()),
  );

  // UseCases
  get.registerLazySingleton(() => GetNowPlayingMovies(repository: get()));
  get.registerLazySingleton(() => GetUpComingMovies(repository: get()));

  // Notifier
  get.registerFactory(() => MovieNotifier(
        getNowPlayingUseCase: get(),
        getUpComingUseCase: get(),
      ));
}