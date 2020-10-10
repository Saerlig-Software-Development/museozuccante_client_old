import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class Failure {
  final Exception e;

  const Failure({this.e});

  String get localizedDescription {
    return 'Errore';
  }
}

class DatabaseFailure extends Failure {}

class NetworkFailure extends Failure {
  final DioError dioError;

  NetworkFailure({this.dioError});

  String get localizedDescription {
    if (dioError is TimeoutException ||
        dioError is SocketException ||
        dioError.response == null) {
      return 'Errore di connessione, cotrolla il tuo collegamento';
    }

    return 'Problema di connessione generico';
  }
}

class ServerFailure extends NetworkFailure {
  final DioError dioError;

  ServerFailure(this.dioError) : super(dioError: dioError);

  String get localizedDescription {
    if (dioError.response.statusCode == 404) {
      return 'Elemento non trovato';
    }

    return 'Problema del server';
  }
}

class NotConnectedFailure extends NetworkFailure {
  String get localizedDescription {
    return "Non connesso a internet";
  }
}

class GenericFailureWithoutException extends GenericFailure {}

class GenericFailure extends Failure {
  GenericFailure({Exception e}) : super(e: e);

  String get localizedDescription {
    return "df";
  }
}
