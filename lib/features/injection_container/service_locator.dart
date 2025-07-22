import 'package:get_it/get_it.dart';
import 'package:ingressos/features/seat/data/datasources/room_data_source.dart';
import 'package:ingressos/features/seat/data/repositories/room_repository_impl.dart';
import 'package:ingressos/features/seat/domain/repositories/room_repository.dart';
import 'package:ingressos/features/seat/domain/usecases/get_available_rooms_usecase.dart';
import 'package:ingressos/features/seat/presenter/provider/room_notifier.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Room Feature
  // Data sources
  sl.registerLazySingleton<RoomDataSource>(() => RoomDataSource());

  // Repositories
  sl.registerLazySingleton<RoomRepository>(
    () => RoomRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAvailableRoomsUseCase(sl()));

  // Providers
  sl.registerFactory(() => RoomNotifier(sl()));
}
