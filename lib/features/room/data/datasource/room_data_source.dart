import 'package:ingressos/features/room/data/model/room_model.dart';

class RoomDataSource {
  static final List<RoomModel> availableRooms = [
    const RoomModel(
      name: "SALA 01 - DUB",
      type: "2D",
      capacity: 196,
    ),
    const RoomModel(
      name: "SALA 02 - DUB",
      type: "3D",
      capacity: 180,
    ),
    const RoomModel(
      name: "SALA 03 - LEG",
      type: "2D",
      capacity: 150,
    ),
    const RoomModel(
      name: "SALA 04 - IMAX",
      type: "IMAX",
      capacity: 220,
    ),
    const RoomModel(
      name: "SALA 05 - VIP",
      type: "2D",
      capacity: 100,
    ),
  ];
}
