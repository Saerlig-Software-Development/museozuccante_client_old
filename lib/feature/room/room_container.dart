import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:museo_zuccante/feature/room/domain/get_items_for_room_usecase.dart';
import 'package:museo_zuccante/feature/room/presentation/bloc/room_items_bloc.dart';

final sl = GetIt.instance;

class RoomContainer {
  static Future<void> init() async {
    sl.registerLazySingleton(
      () => GetItemsUseForRoomUseCase(
        itemsRepository: sl(),
      ),
    );
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<RoomItemsBloc>(
        create: (BuildContext context) => RoomItemsBloc(
          getItemsUseForRoomUseCase: sl(),
        ),
      ),
    ];
  }
}
