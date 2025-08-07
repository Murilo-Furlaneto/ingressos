import 'package:flutter/material.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/payment/presenter/ui/summary_page.dart';
import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/seat/domain/entities/seat_entity.dart';
import 'package:ingressos/features/ticket/data/datasource/ticket_price.dart';
import 'package:ingressos/features/ticket/domain/entities/enum/enum_ticket_status.dart';
import 'package:ingressos/features/ticket/domain/entities/enum_ticket_type.dart';
import 'package:ingressos/features/ticket/domain/entities/ticket_entity.dart';

class TicketSelectionPage extends StatefulWidget {
  const TicketSelectionPage({
    super.key,
    required this.seats,
    required this.movie,
    required this.date,
    required this.session,
    required this.room,
  });

  final List<Seat> seats;
  final Movie movie;
  final DateTime date;
  final String session;
  final Room room;

  @override
  _TicketSelectionPageState createState() => _TicketSelectionPageState();
}

class _TicketSelectionPageState extends State<TicketSelectionPage> {
  final Map<TicketType, int> ticketCounts = {
    for (var type in TicketType.values) type: 0,
  };

  final Map<TicketType, double> ticketPrices = prices;

  double get total => ticketCounts.entries
      .map((e) => ticketPrices[e.key]! * e.value)
      .fold(0.0, (a, b) => a + b);

  bool get canContinue => ticketCounts.values.any((count) => count > 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2D),
      appBar: AppBar(
        title: Text("Selecionar Ingressos"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Escolha o(s) tipo(s) de ingresso e a quantidade desejada:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: TicketType.values.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                final type = TicketType.values[idx];
                return Card(
                  color: Colors.white10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadowColor: Colors.black12,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.confirmation_num,
                          color: Colors.amber,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                type.description,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "R\$ ${ticketPrices[type]!.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.amber,
                              ),
                              onPressed:
                                  ticketCounts[type]! > 0
                                      ? () {
                                        setState(() {
                                          ticketCounts[type] =
                                              ticketCounts[type]! - 1;
                                        });
                                      }
                                      : null,
                              splashRadius: 22,
                            ),
                            SizedBox(
                              width: 28,
                              child: Center(
                                child: Text(
                                  "${ticketCounts[type]}",
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                setState(() {
                                  ticketCounts[type] = ticketCounts[type]! + 1;
                                });
                              },
                              splashRadius: 22,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Footer com valor total e botão destacado
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.9),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Total: R\$ ${total.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFFFBF00,
                    ), // Amber, ótimo contraste
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed:
                      canContinue
                          ? () {
                            final selectedTicketTypes =
                                ticketCounts.keys
                                    .where((key) => ticketCounts[key]! > 0)
                                    .toList();

                            final ticket = Ticket(
                              filme: widget.movie,
                              dataSessao: widget.date,
                              horarioSessao: widget.date,
                              sala: widget.room,
                              tipoIngresso: selectedTicketTypes.first,
                              valor: total,
                              assento: widget.seats,
                              nomeCliente: "",
                              status: TicketStatus.ativo,
                              dataHoraCompra: DateTime.now(),
                              tipoSessao: widget.room.type,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        PurchaseSummaryPage(ticket: ticket),
                              ),
                            );
                          }
                          : null,
                  child: const Text(
                    "Resumo",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
