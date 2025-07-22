import 'package:ingressos/features/seat/data/datasources/room_data_source.dart';
import 'package:ingressos/features/seat/domain/entities/room_entity.dart';
import 'package:ingressos/features/seat/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomDataSource _dataSource;

  RoomRepositoryImpl(this._dataSource);

  @override
  List<Room> getAvailableRooms() {
    return _dataSource.getAvailableRooms();
  }

  @override
  Room? getRoomByName(String name) {
    return _dataSource.getRoomByName(name);
  }
}
