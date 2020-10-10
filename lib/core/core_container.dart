import 'package:alice/alice.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:museo_zuccante/core/infrastructure/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/dio_client.dart';

final sl = GetIt.instance;

class CoreContainer {
  static Future<void> init() async {
    // wait for all modules
    sl.registerLazySingleton<Connectivity>(
      () => Connectivity(),
    );

    sl.registerLazySingleton<Alice>(
      () => Alice(showNotification: false, navigatorKey: navigator),
    );

    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: sl()),
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    sl.registerLazySingleton<Dio>(
      () => DioClient.createDio(
        alice: sl(),
      ),
    );
  }
}
