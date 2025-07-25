
import 'package:flutter/material.dart';
import 'package:ingressos/features/room/domain/entities/room_entity.dart';
import 'package:ingressos/features/room/domain/usecases/room_usecases.dart';

class RoomNotifier extends ChangeNotifier {
  final GetAvailableRoomsUseCase getAvailableRoomsUseCase;
  late List<Room> availableRooms;
  Room? selectedRoom;

  RoomNotifier(this.getAvailableRoomsUseCase) {
    _loadRooms();
  }

  void _loadRooms() {
    availableRooms = getAvailableRoomsUseCase.getRooms();
    notifyListeners();
  }

  void selectRoom(Room room) {
    selectedRoom = room;
    notifyListeners();
  }

  void clearSelection() {
    selectedRoom = null;
    notifyListeners();
  }
}
