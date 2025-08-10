import 'package:flutter/material.dart';
import 'package:ingressos/features/printing/ui/widgets/printing_ticket.dart';
import 'package:ingressos/features/ticket/domain/entities/ticket_entity.dart';

class PrintingTicketPage extends StatelessWidget {
  const PrintingTicketPage({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: IconButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Impressão realizada com sucesso!'),
              backgroundColor: Colors.green, // Para mostrar sucesso visualmente
              duration: Duration(seconds: 3),
            ),
          );
        },
        icon: Icon(Icons.print),
      ),
      body: PrintingTicket(ticket: ticket).preview(),
    );
  }
}
