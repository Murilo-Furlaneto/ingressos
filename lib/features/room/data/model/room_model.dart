import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/ticket/domain/entities/enum/enum_screening%20_type.dart';

class RoomModel extends Room {
  const RoomModel({
    required super.nome,
    required super.tipo,
    required super.capacidade,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      nome: json['nome'] as String,
      tipo: json['tipo'] as ScreeningType,
      capacidade: json['capacidade'] as int,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'tipo': tipo,
      'capacidade': capacidade,
    };
  }

  static Room toEntity(RoomModel model) {
    return Room(
      nome: model.nome,
      tipo: model.tipo,
      capacidade: model.capacidade,
    );
  }

  static RoomModel fromEntity(Room room) {
    return RoomModel(
      nome: room.nome,
      tipo: room.tipo,
      capacidade: room.capacidade,
    );
  }
}
