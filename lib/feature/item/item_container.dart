import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:museo_zuccante/feature/item/domain/usecases/get_item_usecase.dart';
import 'package:museo_zuccante/feature/item/presentation/bloc/item_bloc.dart';

final sl = GetIt.instance;

class ItemContainer {
  static Future<void> init() async {
    sl.registerLazySingleton(
      () => GetItemUseCase(
        itemsRepository: sl(),
      ),
    );
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<ItemBloc>(
        create: (BuildContext context) => ItemBloc(
          getItemUseCase: sl(),
        ),
      ),
    ];
  }
}
