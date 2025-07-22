import 'package:ingressos/features/room/domain/entities/room_entity.dart';

class RoomModel extends Room {
  const RoomModel({
    required String name,
    required String type,
    required int capacity,
  }) : super(
          name: name,
          type: type,
          capacity: capacity,
        );

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      name: json['name'] as String,
      type: json['type'] as String,
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
