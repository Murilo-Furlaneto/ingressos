import 'package:ingressos/features/room/data/model/room_model.dart';
import 'package:ingressos/features/ticket/domain/entities/enum/enum_screening%20_type.dart';

class RoomDataSource {
  static final List<RoomModel> availableRooms = [
    const RoomModel(
      name: "SALA 01",
      type: ScreeningType.doisD,
      capacity: 196,
    ),
    const RoomModel(
      name: "SALA 02",
      type: ScreeningType.tresD,
      capacity: 180,
    ),
    const RoomModel(
      name: "SALA 03",
      type: ScreeningType.doisD,
      capacity: 150,
    ),
    const RoomModel(
      name: "SALA 04",
      type: ScreeningType.imax,
      capacity: 220,
    ),
    const RoomModel(
      name: "SALA 05",
      type: ScreeningType.doisD,
      capacity: 100,
    ),
  ];
}
