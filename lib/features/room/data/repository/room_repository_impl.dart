import 'package:ingressos/features/room/data/datasource/room_data_source.dart';
import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/room/domain/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  @override
  List<Room> getAvailableRooms() {
    return RoomDataSource.availableRooms;
  }

  @override
  Room getRoomByName(String name) {
    return RoomDataSource.availableRooms.firstWhere(
      (room) => room.name == name,
      orElse: () => throw Exception('Sala não encontrada'),
    );
  }
}
