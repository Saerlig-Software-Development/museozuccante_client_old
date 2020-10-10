import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/infrastructure/log/logger.dart';

Failure handleError(Exception e) {
  Logger.e(e, null);
  if (e is DioError) {
    if (e is TimeoutException || e is SocketException || e.response == null) {
      return NetworkFailure(dioError: e);
    } else if (e.response.statusCode >= 500) {
      return ServerFailure(e);
    } else {
      return NetworkFailure(dioError: e);
    }
  } else {
    // check for db failure
    return GenericFailure(e: e);
  }
}
