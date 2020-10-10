import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_remote_datasource.dart';
import 'package:museo_zuccante/feature/items/data/repository/items_repository_impl.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';
import 'package:museo_zuccante/feature/items/domain/usecases/get_items_usecase.dart';
import 'package:museo_zuccante/feature/items/domain/usecases/watch_items_usecase.dart';
import 'package:museo_zuccante/feature/items/presentation/bloc/items_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/watcher/items_watcher_bloc.dart';

final sl = GetIt.instance;

class ItemsContainer {
  static Future<void> init() async {
    sl.registerLazySingleton(() => ItemsRemoteDatasource(dio: sl()));

    sl.registerLazySingleton<ItemsRepository>(
      () => ItemsRepositoryImpl(
        networkInfo: sl(),
        itemsRemoteDatasource: sl(),
        itemsLocalDatasource: sl(),
        sharedPreferences: sl(),
      ),
    );

    sl.registerLazySingleton(
      () => GetItemsUseCase(
        itemsRepository: sl(),
      ),
    );

    sl.registerLazySingleton(
      () => WatchItemsUseCase(
        itemsRepository: sl(),
      ),
    );
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<ItemsBloc>(
        create: (BuildContext context) => ItemsBloc(
          getItemsUseCase: sl(),
        ),
      ),
      BlocProvider<ItemsWatcherBloc>(
        create: (BuildContext context) => ItemsWatcherBloc(
          itemsRepository: sl(),
        ),
      ),
    ];
  }
}
