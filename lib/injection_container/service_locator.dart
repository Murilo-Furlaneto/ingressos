import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ingressos/features/movie/data/datasource/remote_movie_data_source.dart';
import 'package:ingressos/features/movie/data/repository/movies_repository_impl.dart';
import 'package:ingressos/features/movie/domain/repository/movies_repository.dart';
import 'package:ingressos/features/movie/domain/usecases/get_movie_cast.dart';
import 'package:ingressos/features/movie/domain/usecases/get_movie_detail.dart';
import 'package:ingressos/features/movie/domain/usecases/get_movie_reviews.dart';
import 'package:ingressos/features/movie/domain/usecases/get_movie_videos.dart';
import 'package:ingressos/features/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ingressos/features/movie/domain/usecases/get_up_coming.dart';
import 'package:ingressos/features/movie/presenter/provider/movie_notifier.dart';
import 'package:ingressos/features/room/data/datasource/room_data_source.dart';
import 'package:ingressos/features/room/data/repository/room_repository_impl.dart';
import 'package:ingressos/features/room/domain/repository/room_repository.dart';
import 'package:ingressos/features/room/domain/usecases/room_usecases.dart';
import 'package:ingressos/features/room/presenter/provider/room_notifier.dart';

final get = GetIt.instance;

void setupLocator() {
  get.registerLazySingleton(() => http.Client());

  get.registerLazySingleton<RemoteMovieDataSource>(
    () => RemoteMovieDataSource(client: get()),
  );

  get.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(remoteMovieDataSource: get()),
  );

  get.registerLazySingleton<RoomDataSource>(() => RoomDataSource());

  get.registerLazySingleton(() => GetNowPlayingMovies(repository: get()));
  get.registerLazySingleton(() => GetUpComingMovies(repository: get()));
  get.registerLazySingleton(() => GetMovieCast(repository: get()));
  get.registerLazySingleton((() => GetMovieDetail(repository: get())));
  get.registerLazySingleton(() => GetMovieReviews(repository: get()));
  get.registerLazySingleton(() => GetMovieVideos(repository: get()));
  get.registerLazySingleton<RoomDataSource>(() => RoomDataSource());
  get.registerLazySingleton<RoomRepositoryImpl>(() => RoomRepositoryImpl());
  get.registerLazySingleton<RoomRepository>(() => RoomRepositoryImpl());
  get.registerLazySingleton(() => GetAvailableRoomsUseCase(get()));
  get.registerFactory(() => RoomNotifier(get()));
  get.registerLazySingleton<RoomDataSource>(() => RoomDataSource());

  get.registerFactory(
    () => MovieNotifier(
      getNowPlayingUseCase: get(),
      getUpComingUseCase: get(),
      getMovieCastUseCase: get(),
      getMovieDetailUseCase: get(),
      getMovieReviewsUseCase: get(),
      getMovieVideosUseCase: get(),
    ),
  );
}
