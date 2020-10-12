import 'package:flutter/material.dart';

class MapObject {
  final Widget child;

  /// Relative offset from the center of the map for this map object. From -1 to 1 in each dimension.
  final Offset offset;

  /// Size of this object for the zoomLevel == 1
  final Size size;

  MapObject({
    @required this.child,
    @required this.offset,
    this.size,
  });
}
