import 'package:flutter/material.dart';

import 'package:museo_zuccante/feature/rooms/data/models/room_local_model.dart';
import 'package:museo_zuccante/feature/rooms/data/models/room_remote_model.dart';

class RoomDomainModel {
  String id;
  String title;
  int floor;
  int number;
  double offsetX;
  double offsetY;

  RoomDomainModel({
    @required this.id,
    @required this.title,
    @required this.floor,
    @required this.number,
    @required this.offsetX,
    @required this.offsetY,
  });

  RoomDomainModel.fromRemoteModel(RoomRemoteModel roomRemoteModel) {
    this.id = roomRemoteModel.id;
    this.title = roomRemoteModel.title;
    this.floor = roomRemoteModel.floor;
    this.number = roomRemoteModel.number;
    this.offsetX = roomRemoteModel.offsetX;
    this.offsetY = roomRemoteModel.offsetY;
  }

  RoomDomainModel.fromLocalModel(RoomLocalModel roomLocalModel) {
    this.id = roomLocalModel.id;
    this.title = roomLocalModel.title;
    this.floor = roomLocalModel.floor;
    this.number = roomLocalModel.number;
    this.offsetX = roomLocalModel.offsetX;
    this.offsetY = roomLocalModel.offsetY;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomDomainModel &&
        o.id == id &&
        o.title == title &&
        o.floor == floor &&
        o.number == number &&
        o.offsetX == offsetX &&
        o.offsetY == offsetY;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        floor.hashCode ^
        number.hashCode ^
        offsetX.hashCode ^
        offsetY.hashCode;
  }

  @override
  String toString() {
    return 'RoomDomainModel(id: $id, title: $title, floor: $floor, number: $number, offsetX: $offsetX, offsetY: $offsetY)';
  }
}
