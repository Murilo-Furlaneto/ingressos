import 'package:ingressos/features/seat/data/models/room_model.dart';
import 'package:ingressos/features/seat/domain/entities/room_entity.dart';

class RoomDataSource {
  final List<RoomModel> _rooms = [
    const RoomModel(
      name: 'Sala 1',
      type: 'IMAX',
      capacity: 196,
    ),
    const RoomModel(
      name: 'Sala 2',
      type: 'VIP',
      capacity: 140,
    ),
    const RoomModel(
      name: 'Sala 3',
      type: '3D',
      capacity: 196,
    ),
    const RoomModel(
      name: 'Sala 4',
      type: 'DUB',
      capacity: 196,
    ),
    const RoomModel(
      name: 'Sala 5',
      type: 'LEG',
      capacity: 196,
    ),
  ];

  List<Room> getAvailableRooms() {
    return _rooms;
  }

  Room? getRoomByName(String name) {
    try {
      return _rooms.firstWhere((room) => room.name == name);
    } catch (e) {
      return null;
    }
  }
}
