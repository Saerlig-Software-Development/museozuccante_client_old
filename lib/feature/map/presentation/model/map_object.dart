import 'package:flutter/material.dart';
import 'package:museo_zuccante/feature/rooms/domain/model/room_domain_model.dart';

class MapObject {
  final Widget child;

  /// Relative offset from the center of the map for this map object. From -1 to 1 in each dimension.
  final Offset offset;

  /// Size of this object for the zoomLevel == 1
  final Size size;

  // final String id;

  // final String name;

  final RoomDomainModel room;

  MapObject({
    @required this.child,
    @required this.offset,
    this.size,
    @required this.room,
  });
}
