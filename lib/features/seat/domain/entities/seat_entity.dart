import 'package:ingressos/features/seat/domain/enum/seat_status.dart';
import 'package:uuid/uuid.dart';

class Seat{
  final String id = Uuid().v4();
 final SeatStatus status;
 final String posicao;

 Seat({
  required this.status,
  required this.posicao,
 });
}