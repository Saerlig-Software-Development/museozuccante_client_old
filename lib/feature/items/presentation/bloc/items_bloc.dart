import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/domain/usecase.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/usecases/get_items_usecase.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final GetItemsUseCase getItemsUseCase;

  ItemsBloc({
    @required this.getItemsUseCase,
  }) : super(ItemsInitial());

  @override
  Stream<ItemsState> mapEventToState(
    ItemsEvent event,
  ) async* {
    if (event is GetItems) {
      yield* _mapGetItemsEventToState();
    }
  }

  Stream<ItemsState> _mapGetItemsEventToState() async* {
    yield ItemsLoading();

    final itemsResponse = await getItemsUseCase.execute(NoParams());

    yield* itemsResponse.fold((failure) async* {
      yield ItemsFailure(failure: failure);
    }, (items) async* {
      yield ItemsLoaded(items: items);
    });
  }
}
