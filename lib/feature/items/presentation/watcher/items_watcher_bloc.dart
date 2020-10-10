import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';

part 'items_watcher_event.dart';
part 'items_watcher_state.dart';

class ItemsWatcherBloc extends Bloc<ItemsWatcherEvent, ItemsWatcherState> {
  // final WatchItemsUseCase watchItemsUseCase;
  final ItemsRepository itemsRepository;

  StreamSubscription _itemsStreamSubscription;

  ItemsWatcherBloc({
    @required this.itemsRepository,
  }) : super(ItemsWatcherInitial()) {
    _itemsStreamSubscription =
        itemsRepository.watchAllItems().listen((failureOrNotes) {
      print("got vqalues");
      add(ItemsReceived(failureOrItems: failureOrNotes));
    });
  }

  @override
  Stream<ItemsWatcherState> mapEventToState(
    ItemsWatcherEvent event,
  ) async* {
    if (event is ItemsReceived) {
      yield* event.failureOrItems.fold((failure) async* {
        yield ItemsWatcherFailure(failure: failure);
      }, (items) async* {
        yield ItemsWatcherLoadSuccess(items: items);
      });
    }
  }

  @override
  Future<void> close() {
    _itemsStreamSubscription?.cancel();
    return super.close();
  }
}
