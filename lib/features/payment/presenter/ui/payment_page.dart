import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/movie/presenter/ui/widgets/pages/movies_page.dart';
import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/seat/domain/entities/seat_entity.dart';
import 'package:ingressos/features/seat/presenter/ui/pages/seat_selection_page.dart';
import 'package:ingressos/main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
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
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isProcessing = false;

  // Exemplo de dados do Pix
  final String pixCode = "00020126420014br.gov.bcb.pix0138...0213nmocinemav1-...520400005303986540610.005802BR5920CINEMA DIGITAL6009RIO DE JANEIRO62070503***6304E865";

  @override
  Widget build(BuildContext context) {
    final seatList =
        widget.seats.map((e) => e.posicao).toList().join(", ");

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2D),
      appBar: AppBar(
        title: const Text("Pagamento via Pix", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Resumo da compra
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.movie.title,
                        style: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const SizedBox(height: 6),
                    Text(
                      "Data: ${widget.date.day}/${widget.date.month}/${widget.date.year} às ${widget.session}",
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 15),
                    ),
                    Text(
                      "Sala: ${widget.room.name}",
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 15),
                    ),
                    Text(
                      "Assentos: $seatList",
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Escaneie o QR Code para pagar via Pix",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.18),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: QrImageView(
                  data: pixCode,
                  version: QrVersions.auto,
                  size: 210,
                  gapless: false,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 18),
              // Pix Copy-Paste com botão de copiar lateral
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        pixCode.substring(0, 32) + "...", // Mostra só início/final
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      splashRadius: 20,
                      icon: const Icon(Icons.copy, color: Colors.amber),
                      tooltip: "Copiar código Pix",
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: pixCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Código Pix copiado!"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.white24, thickness: 1),
              const SizedBox(height: 24),
              // Botão de imprimir
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFBF00),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: isProcessing
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                            strokeWidth: 3,
                          ),
                        )
                      : const Icon(Icons.print_rounded, size: 24),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      isProcessing ? "Processando..." : "Imprimir ingressos",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  onPressed: isProcessing
                      ? null
                      : () async {
                          setState(() => isProcessing = true);
                          await Future.delayed(const Duration(seconds: 2));
                          setState(() => isProcessing = false);
                          // Aqui navega ou aciona a impressão
                          // Exemplo:
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => PrintTicketPage(...)));
                        },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Após realizar o pagamento, clique em 'Imprimir ingressos'.",
                style: TextStyle(color: Colors.white70, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
