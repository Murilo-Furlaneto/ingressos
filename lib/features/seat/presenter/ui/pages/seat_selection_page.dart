import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/payment/presenter/ui/payment_page.dart';
import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/seat/domain/entities/seat_entity.dart';
import 'package:ingressos/features/seat/domain/enum/seat_status.dart';
import 'package:ingressos/features/ticket/presenter/ui/ticket_selection_page.dart';

class SeatSelectionPage extends StatefulWidget {
  const SeatSelectionPage({
    super.key,
    required this.movie,
    required this.selectedDate,
    required this.selectedSession,
    required this.selectedRoom,
  });

  final Movie movie;
  final DateTime selectedDate;
  final String selectedSession;
  final Room selectedRoom;

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  final List<String> rows = [
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N'];
  final int seatsPerRow = 14;

  late List<List<SeatStatus>> seats;
  List<Seat> selectedSeat = [];

  @override
  void initState() {
    super.initState();

    seats = List.generate(
      rows.length,
      (_) => List.generate(seatsPerRow, (_) => SeatStatus.disponivel),
    );

    final random = Random();
    final numberOfReservedSeats =
        random.nextInt(10) + 5; // 5-15 assentos reservados
    final numberOfBlockedSeats =
        random.nextInt(5) + 3; // 3-8 assentos bloqueados

    for (var i = 0; i < numberOfReservedSeats; i++) {
      final row = random.nextInt(rows.length);
      final col = random.nextInt(seatsPerRow);
      seats[row][col] = SeatStatus.reservado;
    }

    for (var i = 0; i < numberOfBlockedSeats; i++) {
      final row = random.nextInt(rows.length);
      final col = random.nextInt(seatsPerRow);
      seats[row][col] = SeatStatus.bloqueado;
    }
  }

  Color seatColor(SeatStatus status) {
    switch (status) {
      case SeatStatus.disponivel:
        return const Color(0xFF2196F3);
      case SeatStatus.selecionado:
        return const Color(0xFF4CAF50);
      case SeatStatus.reservado:
        return const Color(0xFF9E9E9E);
      case SeatStatus.bloqueado:
        return const Color(0xFFE53935);
    }
  }

  void onSelectedSeat(SeatStatus status, int row, int col) {
    debugPrint("Assento selecionado: ${rows[row]}${col + 1}");
    debugPrint("Status do assento: $status");
    selectedSeat.add(Seat(status: status, posicao: "${rows[row]}${col + 1}"));
  }

  Widget _buildSeat(int row, int col, SeatStatus status) {
    return GestureDetector(
      onTap:
          status == SeatStatus.disponivel
              ? () {
                setState(() {
                  seats[row][col] = SeatStatus.selecionado;
                  onSelectedSeat(seats[row][col], row, col);
                });
              }
              : status == SeatStatus.selecionado
              ? () {
                setState(() {
                  seats[row][col] = SeatStatus.disponivel;
                });
              }
              : null,
      child: Container(
        margin: const EdgeInsets.all(1),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: seatColor(status),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  widget.selectedRoom.name,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color:
                        widget.selectedRoom.type.description == "DUB"
                            ? Colors.purple
                            : widget.selectedRoom.type.description == "IMAX"
                            ? Colors.blue
                            : widget.selectedRoom.type.description == "3D"
                            ? Colors.orange
                            : widget.selectedRoom.type.description == "VIP"
                            ? Colors.amber
                            : Colors.teal,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.selectedRoom.type.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[400]),
                const SizedBox(width: 4),
                Text(
                  "${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year} às ${widget.selectedSession}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        toolbarHeight: 70,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Tela do cinema
          Container(
            width: double.infinity,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[800]!, Colors.grey[600]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                'TELA',
                style: TextStyle(color: Colors.white70, letterSpacing: 8),
              ),
            ),
          ),
          const SizedBox(height: 25),
          // Assentos
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Números das colunas
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          seatsPerRow,
                          (index) => Container(
                            width: 20,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Fileiras de assentos
                    ...List.generate(seats.length, (row) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Letra da fileira
                            SizedBox(
                              width: 25,
                              child: Text(
                                rows[row],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ...List.generate(seatsPerRow, (col) {
                              // Adiciona espaço para o corredor no meio
                              if (col == seatsPerRow ~/ 2) {
                                return const SizedBox(width: 15);
                              }
                              final status = seats[row][col];
                              return _buildSeat(row, col, status);
                            }),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          // Legenda
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Menor padding
              margin: const EdgeInsets.symmetric(horizontal: 50), // Margem maior para diminuir o container
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                spacing: 8, // Reduzido
                runSpacing: 4, // Reduzido
                alignment: WrapAlignment.center, // Centralizado
                children: [
                  _buildLegendItem(const Color(0xFF2196F3), "Disponível"),
                  _buildLegendItem(const Color(0xFF4CAF50), "Selecionado"),
                  _buildLegendItem(const Color(0xFF9E9E9E), "Reservado"),
                  _buildLegendItem(const Color(0xFFE53935), "Bloqueado"),
                ],
              ),
            ),
          )
,
        ],
      ),
      bottomNavigationBar: selectedSeat.isNotEmpty
      ?  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: ElevatedButton(
           style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),

                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => TicketSelectionPage(
                            seats: selectedSeat,
                            movie: widget.movie,
                            date: widget.selectedDate,
                            session: widget.selectedSession,
                            room: widget.selectedRoom,
                          ),
                    ),
                  );
                },
                child: Text("Ingressos", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              ),
      ): null,
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
