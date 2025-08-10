import 'package:ingressos/features/ticket/domain/entities/enum/enum_screening%20_type.dart';

class Room {
  final String nome;
  final ScreeningType tipo;
  final int capacidade;

  const Room({
    required this.nome,
    required this.tipo,
    required this.capacidade,
  });
}
