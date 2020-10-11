import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/feature/item/domain/usecases/get_item_usecase.dart';
import 'package:museo_zuccante/feature/items/data/repository/items_repository_impl.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final GetItemUseCase getItemUseCase;

  ItemBloc({
    @required this.getItemUseCase,
  }) : super(ItemInitial());

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if (event is GetItem) {
      yield ItemLoading();

      final item = await getItemUseCase.execute(GetItemParams(id: event.id));

      yield* item.fold((failure) async* {
        if (failure is ItemNotFoundFailure) {
          yield ItemNotFound();
        } else {
          yield ItemFailure(failure: failure);
        }
      }, (item) async* {
        yield ItemLoaded(item: item);
      });
    }
  }
}
