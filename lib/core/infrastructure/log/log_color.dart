import 'package:flutter/material.dart';
import 'package:f_logs/f_logs.dart' as FLog;
import 'package:museo_zuccante/core/presentation/colors.dart';

extension FLogLogLevelExtension on FLog.LogLevel {
  //ignore: non_constant_identifier_names
  String lsFLogLogLevel_name() => this.toString().substring(9);

  //ignore: non_constant_identifier_names
  Color lsFLogLogLevel_color() {
    switch (this.toString()) {
      case 'LogLevel.WARNING':
        return Colors.orange;
      case 'LogLevel.ERROR':
        return MZColors.errorColor;
      case 'LogLevel.FATAL':
        return Colors.redAccent;
      default:
        return Colors.blueGrey;
    }
  }
}
