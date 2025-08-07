import 'package:flutter/material.dart';
import 'package:ingressos/features/payment/presenter/ui/payment_page.dart';
import 'package:ingressos/features/ticket/domain/entities/ticket_entity.dart';
import 'package:intl/intl.dart';

class PurchaseSummaryPage extends StatefulWidget {
  final Ticket ticket;

  const PurchaseSummaryPage({super.key, required this.ticket});

  @override
  State<PurchaseSummaryPage> createState() => _PurchaseSummaryPageState();
}

class _PurchaseSummaryPageState extends State<PurchaseSummaryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String? _validarNome(String? value) {
      if (value == null || value.isEmpty) {
      return 'O nome é obrigatório';
    }

    if (value.length < 2 || value.length > 50) {
      return 'O nome deve ter entre 2 e 50 caracteres';
    }

    final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
    if (!regex.hasMatch(value)) {
      return 'O nome deve conter apenas letras e espaços';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Resumo da Compra"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome do titular do ingresso
              const Text(
                "Nome do titular do ingresso",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                validator:_validarNome,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Seu nome completo",
                  prefixIcon: const Icon(Icons.person, color: Colors.amber),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: const TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 26),

              // Resumo das informações da compra
              InfoCard(label: "Filme", value: widget.ticket.filme.titulo),
              Row(
                children: [
                  Expanded(
                    child: InfoCard(
                      label: "Data",
                      value: DateFormat(
                        'dd/MM/yyyy',
                      ).format(widget.ticket.dataSessao),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InfoCard(
                      label: "Hora",
                      value: DateFormat(
                        'HH:mm',
                      ).format(widget.ticket.horarioSessao),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InfoCard(
                      label: "Sala",
                      value: widget.ticket.sala.name,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InfoCard(
                      label: "Sessão",
                      value: widget.ticket.tipoSessao.description,
                    ),
                  ),
                ],
              ),
              InfoCard(
                label: "Assentos",
                value: widget.ticket.assento.map((e) => e.posicao).toList().join(", "),
              ),
              InfoCard(
                label: "Tipo de ingresso",
                value: widget.ticket.tipoIngresso.description,
              ),
              const SizedBox(height: 12),
              // Valor total
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      color: Colors.amber,
                      size: 28,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Total: ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'pt_BR',
                        symbol: 'R\$',
                      ).format(widget.ticket.valor),

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Botão para continuar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFBF00),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.pix),
                  label: const Text(
                    "Continuar para o pagamento",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.ticket.nomeCliente = _nameController.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentPage(ticket: widget.ticket),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  const InfoCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(color: Colors.grey, fontSize: 15),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
