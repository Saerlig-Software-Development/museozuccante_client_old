import 'package:flutter/material.dart';

class MzImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const MzImage(
    this.url, {
    Key key,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
    );
  }
}
