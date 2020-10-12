import 'package:floor/floor.dart';

import 'package:museo_zuccante/feature/rooms/data/models/room_remote_model.dart';

@Entity(tableName: 'rooms')
class RoomLocalModel {
  @PrimaryKey()
  String id;
  String title;
  int floor;
  int number;
  @ColumnInfo(name: 'offset_x')
  double offsetX;
  @ColumnInfo(name: 'offset_y')
  double offsetY;

  RoomLocalModel({
    this.id,
    this.title,
    this.floor,
    this.number,
    this.offsetX,
    this.offsetY,
  });

  RoomLocalModel.fromRemoteModel(RoomRemoteModel remote) {
    this.id = remote.id;
    this.title = remote.title;
    this.floor = remote.floor;
    this.number = remote.number;
    this.offsetX = remote.offsetX;
    this.offsetY = remote.offsetY;
  }

  @override
  String toString() {
    return 'RoomLocalModel(id: $id, title: $title, floor: $floor, number: $number, offsetX: $offsetX, offsetY: $offsetY)';
  }
}
