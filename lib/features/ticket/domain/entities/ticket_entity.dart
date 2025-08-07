import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/seat/domain/entities/seat_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:ingressos/features/ticket/domain/entities/enum/enum_screening%20_type.dart';
import 'package:ingressos/features/ticket/domain/entities/enum/enum_ticket_status.dart';
import 'package:ingressos/features/ticket/domain/entities/enum_ticket_type.dart';

class Ticket {
  final String idIngresso = Uuid().v4();
  final Movie filme;
  final String sessaoId = Uuid().v4();
  final DateTime dataSessao;
  final DateTime horarioSessao;
  final Room sala;
  final TicketType tipoIngresso;
  final double valor;
  final List<Seat> assento;
  String nomeCliente;
  final TicketStatus status;
  final DateTime dataHoraCompra;
  final ScreeningType tipoSessao;

  Ticket({
    required this.filme,
    required this.dataSessao,
    required this.horarioSessao,
    required this.sala,
    required this.tipoIngresso,
    required this.valor,
    required this.assento,
    required this.nomeCliente,
    required this.status,
    required this.dataHoraCompra,
    required this.tipoSessao,
  });
}
