import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/generics/resource.dart';
import 'package:museo_zuccante/core/domain/usecase.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/usecases/watch_items_usecase.dart';

part 'items_watcher_event.dart';
part 'items_watcher_state.dart';

class ItemsWatcherBloc extends Bloc<ItemsWatcherEvent, ItemsWatcherState> {
  // final WatchItemsUseCase watchItemsUseCase;
  final WatchItemsUseCase watchItemsUseCase;

  StreamSubscription _itemsStreamSubscription;

  ItemsWatcherBloc({
    @required this.watchItemsUseCase,
  }) : super(ItemsWatcherInitial()) {
    _itemsStreamSubscription =
        watchItemsUseCase.execute(NoParams()).listen((resource) {
      add(ItemsReceived(resource: resource));
    });
  }

  @override
  Stream<ItemsWatcherState> mapEventToState(
    ItemsWatcherEvent event,
  ) async* {
    if (event is ItemsReceived) {
      if (event.resource.status == Status.failed) {
        yield ItemsWatcherFailure(failure: event.resource.failure);
      } else if (event.resource.status == Status.success) {
        yield ItemsWatcherLoadSuccess(items: event.resource.data);
      } else if (event.resource.status == Status.loading) {
        yield ItemsWatcherLoading();
      }
    }
  }

  @override
  Future<void> close() {
    _itemsStreamSubscription?.cancel();
    return super.close();
  }
}
