import 'package:flutter/material.dart';

class ShadowUtils {
  static List<BoxShadow> getDefaultShadow() {
    return <BoxShadow>[
      BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        blurRadius: 1,
        offset: Offset(0, 2),
      ),
    ];
  }
}
