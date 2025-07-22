import 'package:flutter/foundation.dart';
import 'package:ingressos/features/seat/domain/entities/room_entity.dart';
import 'package:ingressos/features/seat/domain/usecases/get_available_rooms_usecase.dart';

class RoomNotifier extends ChangeNotifier {
  final GetAvailableRoomsUseCase getAvailableRoomsUseCase;
  late List<Room> availableRooms;
  Room? selectedRoom;

  RoomNotifier(this.getAvailableRoomsUseCase) {
    _loadRooms();
  }

  void _loadRooms() {
    availableRooms = getAvailableRoomsUseCase();
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
