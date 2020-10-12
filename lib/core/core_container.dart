import 'package:alice/alice.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:museo_zuccante/core/infrastructure/network_info.dart';
import 'package:museo_zuccante/feature/item/item_container.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';
import 'package:museo_zuccante/feature/items/items_container.dart';
import 'package:museo_zuccante/feature/rooms/rooms_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/database/museum_database.dart';
import 'data/dio_client.dart';

final sl = GetIt.instance;

class CoreContainer {
  static Future<void> init() async {
    // wait for all modules
    await ItemsContainer.init();
    await ItemContainer.init();
    await RoomsContainer.init();

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

    final database =
        await $FloorAppDatabase.databaseBuilder('museum_zuccante.db').build();
    sl.registerLazySingleton(() => database);

    sl.registerLazySingleton(() => database.itemsDao);
    sl.registerLazySingleton(() => database.roomsDao);
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      ...ItemsContainer.getBlocProviders(),
      ...ItemContainer.getBlocProviders(),
      ...RoomsContainer.getBlocProviders(),
    ];
  }

  static List<RepositoryProvider> getRepositoryProviders() {
    return [
      RepositoryProvider<ItemsRepository>(
        create: (BuildContext context) => sl(),
      ),
    ];
  }
}
