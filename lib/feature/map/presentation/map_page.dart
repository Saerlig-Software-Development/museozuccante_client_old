import 'package:flutter/material.dart';
import 'package:museo_zuccante/feature/map/presentation/widget/zoom_container.dart';

import 'model/map_object.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ZoomContainer(
          zoomLevel: 4,
          imageProvider: Image.asset("assets/map/ground_floor.png").image,
          objects: [
            MapObject(
              child: Icon(
                Icons.room,
                size: 33,
                color: Colors.red,
              ),
              offset: Offset(0.3, 0),
              size: Size(10, 10),
            ),
          ],
        ),
      ),
    );
  }
}
