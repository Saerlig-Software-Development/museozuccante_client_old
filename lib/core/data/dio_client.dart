import 'dart:io';

import 'package:alice/alice.dart';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/config/api_config.dart';
import 'package:museo_zuccante/core/infrastructure/log/logger.dart';

final GlobalKey<NavigatorState> navigator =
    GlobalKey(); //Create a key for navigator

class DioClient {
  static Dio createDio({
    @required Alice alice,
  }) {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConfig.apiUrl,
      connectTimeout: 10000,
      contentType: ContentType.json.value,
      responseType: ResponseType.json,
    );

    final dio = Dio(options);

    // certificate to solve problems with android simulator
    if (kDebugMode && Platform.isAndroid) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    dio.interceptors.add(DioLogInterceptor());
    dio.interceptors.add(alice.getDioInterceptor());

    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (Response response) {
          Logger.info(
            'DioEND -> Response -> ${response.statusCode} [${response.request.path}] ${response.request.method}  ${response.request.responseType}',
          );

          return response; // continue
        },
        onError: (DioError error) async {
          if (error.response != null) {
            Logger.networkError(
              'DioERROR: ${error.type}',
              Exception(
                'Url: [${error.request.baseUrl}] status:${error.response.statusCode} type:${error.type} Data: ${error.response.data} message: ${error.message}',
              ),
            );
          } else {
            Logger.error('DioERROR', error, null);
          }

          return error;
        },
      ),
    );

    return dio;
  }
}
