import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/exceptions/successes.dart';
import 'package:museo_zuccante/feature/items/domain/usecases/update_items_usecase.dart';

part 'items_updater_event.dart';
part 'items_updater_state.dart';

class ItemsUpdaterBloc extends Bloc<ItemsUpdaterEvent, ItemsUpdaterState> {
  UpdateItemsUseCase updateItemsUseCase;

  ItemsUpdaterBloc({
    @required this.updateItemsUseCase,
  }) : super(ItemsUpdaterInitial());

  @override
  Stream<ItemsUpdaterState> mapEventToState(
    ItemsUpdaterEvent event,
  ) async* {
    if (event is UpdateItemsIfNeeded) {
      yield ItemsUpdaterLoading();

      final update = await updateItemsUseCase.execute(
        UpdateItemsParams(ifNeeded: true),
      );

      yield* update.fold((failure) async* {
        yield ItemsUpdaterFailure(failure: failure);
      }, (success) async* {
        yield ItemsUpdaterSuccess(success: success);
      });
    } else if (event is UpdateItems) {
      yield ItemsUpdaterLoading();

      final update = await updateItemsUseCase.execute(
        UpdateItemsParams(ifNeeded: false),
      );

      yield* update.fold((failure) async* {
        yield ItemsUpdaterFailure(failure: failure);
      }, (success) async* {
        yield ItemsUpdaterSuccess(success: success);
      });
    }
  }
}
