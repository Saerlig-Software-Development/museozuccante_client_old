import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:museo_zuccante/feature/rooms/presentation/updater/rooms_updater_bloc.dart';
import 'package:museo_zuccante/feature/rooms/presentation/watcher/rooms_watcher_bloc.dart';

import 'data/datasources/rooms_remote_datasource.dart';
import 'data/repository/rooms_repository_impl.dart';
import 'domain/repository/rooms_repository.dart';
import 'domain/usecase/update_rooms_usecase.dart';
import 'domain/usecase/watch_rooms_usecase.dart';

final sl = GetIt.instance;

class RoomsContainer {
  static Future<void> init() async {
    sl.registerLazySingleton(() => RoomsRemoteDatasource(dio: sl()));

    // sl.registerLazySingleton(() => RoomsRemoteDatasource(dio: sl()));

    sl.registerLazySingleton<RoomsRepository>(
      () => RoomsRepositoryImpl(
        networkInfo: sl(),
        roomsRemoteDatasource: sl(),
        roomsLocalDatasource: sl(),
        sharedPreferences: sl(),
      ),
    );

    sl.registerLazySingleton(
      () => WatchRoomsUseCase(
        roomsRepository: sl(),
      ),
    );

    sl.registerLazySingleton(
      () => UpdateRoomsUseCase(
        roomsRepository: sl(),
      ),
    );
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<RoomsWatcherBloc>(
        create: (BuildContext context) => RoomsWatcherBloc(
          watchRoomsUseCase: sl(),
        ),
      ),
      BlocProvider<RoomsUpdaterBloc>(
        create: (BuildContext context) => RoomsUpdaterBloc(
          updateRoomsUseCase: sl(),
        ),
      ),
    ];
  }
}
