import 'package:ingressos/features/room/domain/entities/room_entity.dart';

abstract class RoomRepository {
  List<Room> getAvailableRooms();
  Room getRoomByName(String name);
}
