import 'package:floor/floor.dart';
import 'package:museo_zuccante/feature/items/data/models/item_remote_model.dart';

@Entity(tableName: 'items')
class ItemLocalModel {
  @PrimaryKey()
  String id;
  String title;
  String subtitle;
  String poster;
  String body;
  bool highlighted;

  @ColumnInfo(name: 'room_id')
  String roomId;
  @ColumnInfo(name: 'room_title')
  String roomTitle;
  @ColumnInfo(name: 'room_floor')
  int roomFloor;
  @ColumnInfo(name: 'room_number')
  int roomNumber;

  ItemLocalModel({
    this.id,
    this.title,
    this.subtitle,
    this.poster,
    this.body,
    this.roomId,
    this.roomTitle,
    this.roomFloor,
    this.roomNumber,
    this.highlighted,
  });

  ItemLocalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    poster = json['poster'];
    body = json['body'];
    highlighted = json['highlighted'];
    roomId = json['room'] != null ? json['room']['id'] : null;
    roomTitle = json['room'] != null ? json['room']['title'] : null;
    roomFloor = json['room'] != null ? json['room']['floor'] : null;
    roomNumber = json['room'] != null ? json['room']['number'] : null;
  }

  ItemLocalModel.fromRemoteModel(ItemRemoteModel remote) {
    this.id = remote.id;
    this.title = remote.title;
    this.subtitle = remote.subtitle;
    this.poster = remote.poster;
    this.body = remote.body;
    this.roomId = remote.room.id;
    this.roomTitle = remote.room.title;
    this.roomFloor = remote.room.floor;
    this.roomNumber = remote.room.number;
    this.highlighted = remote.highlighted;
  }

  @override
  String toString() {
    return 'ItemLocalModel(id: $id, title: $title, subtitle: $subtitle, poster: $poster, body: $body, roomId: $roomId, roomTitle: $roomTitle, roomFloor: $roomFloor, roomNumber: $roomNumber)';
  }
}
