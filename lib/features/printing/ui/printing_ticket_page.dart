import 'package:flutter/material.dart';
import 'package:ingressos/features/movie/domain/entities/movie_entity.dart';
import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/seat/domain/entities/seat_entity.dart';

class PrintingTicketPage extends StatelessWidget {

  const PrintingTicketPage({ super.key, required this.seats, required this.movie, required this.date, required this.session, required this.room });

  final List<Seat> seats;
  final Movie movie;
  final DateTime date;
  final String session;
  final Room room;

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text(''),),
           body: ListView(
            children: [],
           ),
       );
  }
}