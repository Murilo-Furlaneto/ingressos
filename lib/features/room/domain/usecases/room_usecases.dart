import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/room/domain/repository/room_repository.dart';

class GetAvailableRoomsUseCase {
  final RoomRepository repository;

  GetAvailableRoomsUseCase(this.repository);

  List<Room> getRooms() {
    return repository.getAvailableRooms();
  }
}

class GetRoomByNameUseCase {
  final RoomRepository repository;

  GetRoomByNameUseCase(this.repository);

  Room getRoomByName(String name) {
    return repository.getRoomByName(name);
  }
}
