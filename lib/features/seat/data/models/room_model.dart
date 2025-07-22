import 'package:ingressos/features/seat/domain/entities/room_entity.dart';

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
}
