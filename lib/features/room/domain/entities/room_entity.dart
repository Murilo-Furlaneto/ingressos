import 'package:ingressos/features/ticket/domain/entities/enum/enum_screening%20_type.dart';

class Room {
  final String name;
  final ScreeningType type;
  final int capacity;

  const Room({
    required this.name,
    required this.type,
    required this.capacity,
  });
}
