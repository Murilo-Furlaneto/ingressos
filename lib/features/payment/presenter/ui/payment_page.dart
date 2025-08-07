import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ingressos/features/ticket/domain/entities/ticket_entity.dart';
import 'package:qr_flutter/qr_flutter.dart';
class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.ticket,
  });


  final Ticket ticket;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isProcessing = false;

  final String pixCode = dotenv.get("PIX_CODE");
  @override
  Widget build(BuildContext context) {
    final seatList =
        widget.ticket.assento.map((e) => e.posicao).toList().join(", ");

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
                    Text(widget.ticket.filme.titulo,
                        style: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const SizedBox(height: 6),
                    Text(
                      "Data: ${widget.ticket.dataSessao.day}/${widget.ticket.dataSessao.month}/${widget.ticket.dataSessao.year} às ${widget.ticket.horarioSessao}",
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 15),
                    ),
                    Text(
                      "Sala: ${widget.ticket.sala.name}",
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
                        pixCode.substring(0, 32) + "...", 
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
                        
                         //  Navigator.push(context, MaterialPageRoute(builder: (_) => PrintTicketPage()));
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
