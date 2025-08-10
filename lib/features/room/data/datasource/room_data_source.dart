import 'package:ingressos/features/room/data/model/room_model.dart';
import 'package:ingressos/features/ticket/domain/entities/enum/enum_screening%20_type.dart';

class RoomDataSource {
  static final List<RoomModel> availableRooms = [
    const RoomModel(
      nome: "SALA 01",
      tipo: ScreeningType.doisD,
      capacidade: 196,
    ),
    const RoomModel(
      nome: "SALA 02",
      tipo: ScreeningType.tresD,
      capacidade: 180,
    ),
    const RoomModel(
      nome: "SALA 03",
      tipo: ScreeningType.doisD,
      capacidade: 150,
    ),
    const RoomModel(
      nome: "SALA 04",
      tipo: ScreeningType.imax,
      capacidade: 220,
    ),
    const RoomModel(
      nome: "SALA 05",
      tipo: ScreeningType.doisD,
      capacidade: 100,
    ),
  ];
}
