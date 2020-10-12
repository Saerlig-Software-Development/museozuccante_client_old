import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/feature/map/presentation/model/map_object.dart';
import 'package:museo_zuccante/feature/map/presentation/widget/image_viewport.dart';

class ZoomContainer extends StatefulWidget {
  final double zoomLevel;
  final ImageProvider imageProvider;
  final List<MapObject> objects;

  ZoomContainer({
    Key key,
    this.zoomLevel = 1,
    @required this.imageProvider,
    this.objects = const [],
  }) : super(key: key);

  @override
  _ZoomContainerState createState() => _ZoomContainerState();
}

class _ZoomContainerState extends State<ZoomContainer> {
  double _zoomLevel;
  ImageProvider _imageProvider;
  List<MapObject> _objects;

  @override
  void initState() {
    super.initState();
    _zoomLevel = widget.zoomLevel;
    _imageProvider = widget.imageProvider;
    _objects = widget.objects;
  }

  @override
  void didUpdateWidget(ZoomContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageProvider != _imageProvider)
      _imageProvider = widget.imageProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ImageViewport(
          zoomLevel: _zoomLevel,
          imageProvider: _imageProvider,
          objects: _objects,
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          child: Row(
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {
                  HapticFeedback.vibrate();

                  setState(() {
                    _zoomLevel = _zoomLevel * 2;
                  });
                },
                elevation: 2.0,
                fillColor: MZColors.primary,
                child: Icon(
                  Icons.zoom_in,
                  color: Colors.white,
                  size: 21.0,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              SizedBox(
                width: 5,
              ),
              RawMaterialButton(
                onPressed: () {
                  HapticFeedback.vibrate();

                  setState(() {
                    _zoomLevel = _zoomLevel / 2;
                  });
                },
                elevation: 2.0,
                fillColor: MZColors.primary,
                child: Icon(
                  Icons.zoom_out,
                  color: Colors.white,
                  size: 21.0,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
