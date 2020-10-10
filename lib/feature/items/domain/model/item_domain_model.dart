import 'package:flutter/material.dart';

import 'package:museo_zuccante/feature/items/data/models/item_local_model.dart';
import 'package:museo_zuccante/feature/items/data/models/item_remote_model.dart';

class ItemDomainModel {
  String id;
  String title;
  String subtitle;
  String poster;
  String body;
  RoomDomainModel room;

  ItemDomainModel({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.poster,
    @required this.body,
    @required this.room,
  });

  ItemDomainModel.fromRemoteModel(ItemRemoteModel remote) {
    this.id = remote.id;
    this.title = remote.title;
    this.subtitle = remote.subtitle;
    this.poster = remote.poster;
    this.body = remote.body;
    this.room = RoomDomainModel(
      id: remote.room.id,
      title: remote.room.title,
      floor: remote.room.floor,
      number: remote.room.number,
    );
  }

  ItemDomainModel.fromLocalModel(ItemLocalModel local) {
    this.id = local.id;
    this.title = local.title;
    this.subtitle = local.subtitle;
    this.poster = local.poster;
    this.body = local.body;
    this.room = RoomDomainModel(
      id: local.roomId,
      number: local.roomNumber,
      floor: local.roomFloor,
      title: local.roomTitle,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ItemDomainModel &&
        o.id == id &&
        o.title == title &&
        o.subtitle == subtitle &&
        o.poster == poster &&
        o.body == body &&
        o.room == room;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        poster.hashCode ^
        body.hashCode ^
        room.hashCode;
  }

  @override
  String toString() {
    return 'ItemDomainModel(id: $id, title: $title, subtitle: $subtitle, poster: $poster, body: $body, room: $room)';
  }
}

class RoomDomainModel {
  String id;
  String title;
  int floor;
  int number;

  RoomDomainModel({
    @required this.id,
    @required this.title,
    @required this.floor,
    @required this.number,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomDomainModel &&
        o.id == id &&
        o.title == title &&
        o.floor == floor &&
        o.number == number;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ floor.hashCode ^ number.hashCode;
  }

  @override
  String toString() {
    return 'RoomDomainModel(id: $id, title: $title, floor: $floor, number: $number)';
  }
}
