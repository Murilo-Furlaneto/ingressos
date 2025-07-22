import 'package:ingressos/features/seat/domain/entities/room_entity.dart';
import 'package:ingressos/features/seat/domain/repositories/room_repository.dart';

class GetAvailableRoomsUseCase {
  final RoomRepository repository;

  GetAvailableRoomsUseCase(this.repository);

  List<Room> call() {
    return repository.getAvailableRooms();
  }
}
