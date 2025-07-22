import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/seat/domain/enum/seat_status.dart';

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
  final List<String> rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N'];
  final int seatsPerRow = 14;
  
  // Matriz de assentos mais realista
  late List<List<SeatStatus>> seats;
  
  @override
  void initState() {
    super.initState();
    
    // Inicializa todos os assentos como disponíveis
    seats = List.generate(
      rows.length,
      (_) => List.generate(seatsPerRow, (_) => SeatStatus.disponivel),
    );
    
    // Gera assentos reservados e bloqueados aleatoriamente
    final random = Random();
    final numberOfReservedSeats = random.nextInt(10) + 5; // 5-15 assentos reservados
    final numberOfBlockedSeats = random.nextInt(5) + 3; // 3-8 assentos bloqueados
    
    // Adiciona assentos reservados aleatoriamente
    for (var i = 0; i < numberOfReservedSeats; i++) {
      final row = random.nextInt(rows.length);
      final col = random.nextInt(seatsPerRow);
      seats[row][col] = SeatStatus.reservado;
    }
    
    // Adiciona assentos bloqueados aleatoriamente
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

  Widget _buildSeat(int row, int col, SeatStatus status) {
    return GestureDetector(
      onTap: status == SeatStatus.disponivel
          ? () {
              setState(() {
                seats[row][col] = SeatStatus.selecionado;
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
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey,
                ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: widget.selectedRoom.type == "DUB" ? Colors.purple :
                           widget.selectedRoom.type == "IMAX" ? Colors.blue :
                           widget.selectedRoom.type == "3D" ? Colors.orange :
                           widget.selectedRoom.type == "VIP" ? Colors.amber :
                           Colors.teal,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.selectedRoom.type,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey[400],
                ),
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
        toolbarHeight: 100,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
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
          const SizedBox(height: 40),
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
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
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
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                _buildLegendItem(const Color(0xFF2196F3), "Disponível"),
                _buildLegendItem(const Color(0xFF4CAF50), "Selecionado"),
                _buildLegendItem(const Color(0xFF9E9E9E), "Reservado"),
                _buildLegendItem(const Color(0xFFE53935), "Bloqueado"),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
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
