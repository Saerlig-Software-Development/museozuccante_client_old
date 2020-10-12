import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:museo_zuccante/feature/map/presentation/model/map_object.dart';
import 'package:museo_zuccante/feature/map/presentation/widget/map_painter.dart';

class ImageViewport extends StatefulWidget {
  final double zoomLevel;
  final ImageProvider imageProvider;
  final List<MapObject> objects;

  ImageViewport({
    Key key,
    @required this.zoomLevel,
    @required this.imageProvider,
    this.objects,
  }) : super(key: key);

  @override
  _ImageViewportState createState() => _ImageViewportState();
}

class _ImageViewportState extends State<ImageViewport> {
  double _zoomLevel;
  ImageProvider _imageProvider;
  ui.Image _image;
  bool _resolved;
  Offset _centerOffset;
  double _maxHorizontalDelta;
  double _maxVerticalDelta;
  Offset _normalized;
  bool _denormalize = false;
  Size _actualImageSize;
  Size _viewportSize;

  List<MapObject> _objects;

  double abs(double value) {
    return value < 0 ? value * (-1) : value;
  }

  void _updateActualImageDimensions() {
    _actualImageSize = Size(
        (_image.width / window.devicePixelRatio) * _zoomLevel,
        (_image.height / ui.window.devicePixelRatio) * _zoomLevel);
  }

  @override
  void initState() {
    super.initState();
    _zoomLevel = widget.zoomLevel;
    _imageProvider = widget.imageProvider;
    _resolved = false;
    _centerOffset = Offset(0, 0);
    _objects = widget.objects;
  }

  void _resolveImageProvider() {
    ImageStream stream =
        _imageProvider.resolve(createLocalImageConfiguration(context));

    stream.addListener(ImageStreamListener((ImageInfo info, _) {
      _image = info.image;
      _resolved = true;
      _updateActualImageDimensions();
      setState(() {});
    }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImageProvider();
  }

  @override
  void didUpdateWidget(ImageViewport oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageProvider != _imageProvider) {
      _imageProvider = widget.imageProvider;
      _resolveImageProvider();
    }
    double normalizedDx =
        _maxHorizontalDelta == 0 ? 0 : _centerOffset.dx / _maxHorizontalDelta;
    double normalizedDy =
        _maxVerticalDelta == 0 ? 0 : _centerOffset.dy / _maxVerticalDelta;
    _normalized = Offset(normalizedDx, normalizedDy);
    _denormalize = true;
    _zoomLevel = widget.zoomLevel;
    _updateActualImageDimensions();
  }

  ///This is used to convert map objects relative global offsets from the map center
  ///to the local viewport offset from the top left viewport corner.
  Offset _globaltoLocalOffset(Offset value) {
    double hDelta = (_actualImageSize.width / 2) * value.dx;
    double vDelta = (_actualImageSize.height / 2) * value.dy;
    double dx = (hDelta - _centerOffset.dx) + (_viewportSize.width / 2);
    double dy = (vDelta - _centerOffset.dy) + (_viewportSize.height / 2);
    return Offset(dx, dy);
  }

  ///This is used to convert global coordinates of long press event on the map to relative global offsets from the map center
  Offset _localToGlobalOffset(Offset value) {
    double dx = value.dx - _viewportSize.width / 2;
    double dy = value.dy - _viewportSize.height / 2;
    double dh = dx + _centerOffset.dx;
    double dv = dy + _centerOffset.dy;
    return Offset(
      dh / (_actualImageSize.width / 2),
      dv / (_actualImageSize.height / 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    void handleDrag(DragUpdateDetails updateDetails) {
      Offset newOffset = _centerOffset.translate(
          -updateDetails.delta.dx, -updateDetails.delta.dy);
      if (abs(newOffset.dx) <= _maxHorizontalDelta &&
          abs(newOffset.dy) <= _maxVerticalDelta)
        setState(() {
          _centerOffset = newOffset;
        });
    }

    void addMapObject(MapObject object) => setState(() {
          _objects.add(object);
        });

    void removeMapObject(MapObject object) => setState(() {
          _objects.remove(object);
        });

    List<Widget> buildObjects() {
      return _objects
          .map(
            (MapObject object) => Positioned(
              left: _globaltoLocalOffset(object.offset).dx -
                  (object.size == null
                      ? 0
                      : (object.size.width * _zoomLevel) / 2),
              top: _globaltoLocalOffset(object.offset).dy -
                  (object.size == null
                      ? 0
                      : (object.size.height * _zoomLevel) / 2),
              child: GestureDetector(
                onTapUp: (TapUpDetails details) {
                  MapObject info;
                  info = MapObject(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 1,
                      )),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Close me"),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => removeMapObject(info),
                          ),
                        ],
                      ),
                    ),
                    offset: object.offset,
                    size: null,
                  );
                  addMapObject(info);
                },
                child: Container(
                  width: object.size == null
                      ? null
                      : object.size.width * _zoomLevel,
                  height: object.size == null
                      ? null
                      : object.size.height * _zoomLevel,
                  child: object.child,
                ),
              ),
            ),
          )
          .toList();
    }

    return _resolved
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              _viewportSize = Size(
                  min(constraints.maxWidth, _actualImageSize.width),
                  min(constraints.maxHeight, _actualImageSize.height));
              _maxHorizontalDelta =
                  (_actualImageSize.width - _viewportSize.width) / 2;
              _maxVerticalDelta =
                  (_actualImageSize.height - _viewportSize.height) / 2;
              bool reactOnHorizontalDrag =
                  _maxHorizontalDelta > _maxVerticalDelta;
              bool reactOnPan =
                  (_maxHorizontalDelta > 0 && _maxVerticalDelta > 0);
              if (_denormalize) {
                _centerOffset = Offset(_maxHorizontalDelta * _normalized.dx,
                    _maxVerticalDelta * _normalized.dy);
                _denormalize = false;
              }

              return GestureDetector(
                onPanUpdate: reactOnPan ? handleDrag : null,
                onHorizontalDragUpdate:
                    reactOnHorizontalDrag && !reactOnPan ? handleDrag : null,
                onVerticalDragUpdate:
                    !reactOnHorizontalDrag && !reactOnPan ? handleDrag : null,
                onLongPressEnd: (LongPressEndDetails details) {
                  RenderBox box = context.findRenderObject();
                  Offset localPosition =
                      box.globalToLocal(details.globalPosition);
                  Offset newObjectOffset = _localToGlobalOffset(localPosition);
                  MapObject newObject = MapObject(
                    child: Container(
                      color: Colors.blue,
                    ),
                    offset: newObjectOffset,
                    size: Size(10, 10),
                  );
                  addMapObject(newObject);
                },
                child: Stack(
                  children: <Widget>[
                        CustomPaint(
                          size: _viewportSize,
                          painter:
                              MapPainter(_image, _zoomLevel, _centerOffset),
                        ),
                      ] +
                      buildObjects(),
                ),
              );
            },
          )
        : SizedBox();
  }
}
