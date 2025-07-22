import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:ingressos/features/ticket/domain/entities/enum/enum_screening%20_type.dart';
import 'package:ingressos/features/ticket/domain/entities/enum/enum_ticket_status.dart';
import 'package:ingressos/features/ticket/domain/entities/enum_ticket_type.dart';

class Ticket {
  final String idIngresso = Uuid().v4();
  final String nomeFilme;
  final String sessaoId =  Uuid().v4();
  final DateTime dataSessao;
  final DateTime horarioSessao;
  final int numeroSala;
  final TicketType tipoIngresso;
  final double valor;
  final String assento;
  final String nomeCliente;
  final QrCode qrCode;
  final TicketStatus status;
  final DateTime dataHoraCompra;
  final ScreeningType tipoSessao;
 
  Ticket({
    required this.nomeFilme,
    required this.dataSessao,
    required this.horarioSessao,
    required this.numeroSala,
    required this.tipoIngresso,
    required this.valor,
    required this.assento,
    required this.nomeCliente,
    required this.qrCode,
    required this.status,
    required this.dataHoraCompra,
    required this.tipoSessao,
  });
  
}
