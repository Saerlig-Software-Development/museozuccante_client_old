import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/feature/map/presentation/widget/zoom_container.dart';
import 'package:museo_zuccante/feature/rooms/domain/model/room_domain_model.dart';

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
              room: RoomDomainModel(
                id: '7a057219-3dee-402f-9e22-5e8c41b8760c',
                title: 'Aula',
                floor: 1,
                number: 1,
                offsetX: 0.3,
                offsetY: 0.3,
              ),
              child: Icon(
                Icons.room,
                size: 33,
                color: MZColors.primary,
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
