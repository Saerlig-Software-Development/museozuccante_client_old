import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  /// starts at null and ends at 16
  double _left;

  // double _bottom;

  double _height = 62;
  double _width = 62;

  double _size = 35;

  bool _setToMaxWidth = false;

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
              // child: FutureBuilder(
              //   future: Permission.camera.status,
              //   initialData: null,
              //   builder: (BuildContext context,
              //       AsyncSnapshot<PermissionStatus> snapshot) {
              //     if (snapshot != null && snapshot.data.isGranted) {
              //       return QRView(
              //         key: qrKey,
              //         onQRViewCreated: _onQRViewCreated,
              //       );
              //     } else {

              //     }
              //     return Hero(
              //       tag: 'qrcode',
              //       child: Icon(
              //         CupertinoIcons.qrcode_viewfinder,
              //         size: _size,
              //       ),
              //     );
              //   },
              // ),
              child: _loadingQRView
                  ? Hero(
                      tag: 'qrcode',
                      child: Icon(
                        CupertinoIcons.qrcode_viewfinder,
                        size: _size,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: QRView(
                        // overlay: ShapeBorder.,
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this._qrViewController = controller;
    _qrViewController.scannedDataStream.listen((scanData) {
      _qrViewController.dispose();

      _qrViewController.toggleFlash();
      Navigator.of(context, rootNavigator: true).pop();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ItemLoaderPage(
              id: scanData,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }
}
