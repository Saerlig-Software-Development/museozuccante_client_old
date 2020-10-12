import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/feature/item/presentation/item_loader_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AnimatedQRDialog extends StatefulWidget {
  AnimatedQRDialog({Key key}) : super(key: key);

  @override
  _AnimatedQRDialogState createState() => _AnimatedQRDialogState();
}

class _AnimatedQRDialogState extends State<AnimatedQRDialog>
    with TickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";

  AnimationController controller;

  QRViewController _qrViewController;

  double _top = 16;
  double _right = 16;

  bool _loadingQRView = true;

  bool _flashOn = false;
  bool _frontCamera = false;

  /// starts at null and ends at 16
  double _left;

  // double _bottom;

  double _height = 62;
  double _width = 62;

  double _size = 35;

  bool _setToMaxWidth = false;

  double _opacity = 0.0;

  Color _closeButtonColor = Colors.red;

  Timer _opacityTimer;

  @override
  void initState() {
    super.initState();

    startAnimations();
  }

  void startAnimations() async {
    Future.delayed(Duration(milliseconds: 800)).then((value) {
      setState(() {
        _loadingQRView = false;
      });
    });

    await Future.delayed(Duration(milliseconds: 1));
    setState(() {
      // _width = 400;

      _setToMaxWidth = true;
    });

    Future.delayed(Duration(milliseconds: 250)).then((value) {
      setState(() {
        _left = 16;
      });
    });

    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      _height = 450;
      _size = 84;
    });

    _opacityTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_opacity == 0) {
        setState(() {
          _opacity = 1;
        });
      } else {
        setState(() {
          _opacity = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Material(
              borderRadius: BorderRadius.circular(8.0),
              child: Ink(
                decoration: BoxDecoration(
                  color: _closeButtonColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    // Navigator.pop(context);
                    setState(() {
                      _loadingQRView = true;
                      _closeButtonColor = MZColors.primary;
                      _height = 0;
                    });

                    Future.delayed(Duration(milliseconds: 200)).then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            top: _top + _height + 8,
            left: 16,
            right: 16,
          ),
          Positioned(
            // bottom: ,
            top: _top,
            right: _right,
            left: _left,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              width:
                  _setToMaxWidth ? MediaQuery.of(context).size.width : _width,
              height: _height,
              decoration: BoxDecoration(
                color: MZColors.alternativeBackgroundColor,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: _loadingQRView
                  ? Hero(
                      tag: 'qrcode',
                      child: Icon(
                        CupertinoIcons.qrcode_viewfinder,
                        size: _size,
                      ),
                    )
                  : _buildQRView(),
            ),
          ),
          Positioned(
            top: _top + _height - 60,
            left: MediaQuery.of(context).size.width / 2 - 100,
            right: MediaQuery.of(context).size.width / 2 - 100,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(milliseconds: 600),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Scanning for QR',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRView() {
    // return Material(
    //   child: RawMaterialButton(
    //     onPressed: () {
    //       setState(() {
    //         _flashOn = !_flashOn;
    //       });
    //     },
    //     elevation: 2.0,
    //     fillColor: MZColors.lightGrey,
    //     child: Icon(
    //       _flashOn ? Icons.flash_off : Icons.flash_on,
    //       color: Colors.white,
    //       size: 35.0,
    //     ),
    //     padding: EdgeInsets.all(15.0),
    //     shape: CircleBorder(),
    //   ),
    // );
    return Material(
      borderRadius: BorderRadius.circular(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: QRView(
                // overlay: ShapeBorder.,
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Positioned(
              top: 16,
              left: 0,
              child: RawMaterialButton(
                onPressed: () {
                  HapticFeedback.vibrate();

                  setState(() {
                    _qrViewController.toggleFlash();
                    _flashOn = !_flashOn;
                  });
                },
                elevation: 2.0,
                fillColor: MZColors.lightGrey,
                child: Icon(
                  _flashOn ? Icons.flash_off : Icons.flash_on,
                  color: Colors.white,
                  size: 21.0,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ),
            Positioned(
              top: 16,
              right: 0,
              child: RawMaterialButton(
                onPressed: () {
                  HapticFeedback.vibrate();
                  setState(() {
                    _qrViewController.flipCamera();
                    _frontCamera = !_frontCamera;
                  });
                },
                elevation: 2.0,
                fillColor: MZColors.lightGrey,
                child: Icon(
                  Icons.switch_camera_rounded,
                  color: Colors.white,
                  size: 21.0,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this._qrViewController = controller;
    _qrViewController.scannedDataStream.listen((scanData) {
      _qrViewController.pauseCamera();

      // _qrViewController.toggleFlash();
      // Navigator.of(context, rootNavigator: true).pop();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ItemLoaderPage(
              id: scanData,
            );
          },
        ),
      ).then((value) {
        _qrViewController.resumeCamera();
      });
    });
  }

  @override
  void dispose() {
    _opacityTimer.cancel();
    super.dispose();
  }
}
