import 'package:floor/floor.dart';
import 'package:museo_zuccante/feature/rooms/data/models/room_local_model.dart';

@dao
abstract class RoomsLocalDatasource {
  @Query("SELECT * FROM rooms")
  Future<List<RoomLocalModel>> getRooms();

  @Query('SELECT * FROM rooms WHERE id = :id')
  Future<RoomLocalModel> findRoomById(String id);

  @Query("SELECT * FROM rooms")
  Stream<List<RoomLocalModel>> watchRooms();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRoom(RoomLocalModel room);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertRooms(List<RoomLocalModel> rooms);

  @Query('DELETE FROM rooms')
  Future<void> deleteAllRooms();

  @delete
  Future<void> deleteRooms(List<RoomLocalModel> rooms);
}
