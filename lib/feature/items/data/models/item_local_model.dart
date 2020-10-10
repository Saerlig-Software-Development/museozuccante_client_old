import 'package:floor/floor.dart';

@Entity(tableName: 'item')
class ItemLocalModel {
  @PrimaryKey()
  String id;
  String title;
  String subtitle;
  String poster;
  String body;

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
  });

  ItemLocalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    poster = json['poster'];
    body = json['body'];
    roomId = json['room'] != null ? json['room']['id'] : null;
    roomTitle = json['room'] != null ? json['room']['title'] : null;
    roomFloor = json['room'] != null ? json['room']['floor'] : null;
    roomNumber = json['room'] != null ? json['room']['number'] : null;
  }

  @override
  String toString() {
    return 'ItemLocalModel(id: $id, title: $title, subtitle: $subtitle, poster: $poster, body: $body, roomId: $roomId, roomTitle: $roomTitle, roomFloor: $roomFloor, roomNumber: $roomNumber)';
  }
}
