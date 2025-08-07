import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/ticket/domain/entities/enum/enum_screening%20_type.dart';

class RoomModel extends Room {
  const RoomModel({
    required super.name,
    required super.type,
    required super.capacity,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      name: json['name'] as String,
      type: json['type'] as ScreeningType,
      capacity: json['capacity'] as int,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'capacity': capacity,
    };
  }

  static Room toEntity(RoomModel model) {
    return Room(
      name: model.name,
      type: model.type,
      capacity: model.capacity,
    );
  }

  static RoomModel fromEntity(Room room) {
    return RoomModel(
      name: room.name,
      type: room.type,
      capacity: room.capacity,
    );
  }
}
