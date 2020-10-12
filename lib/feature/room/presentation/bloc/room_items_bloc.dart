import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/room/domain/get_items_for_room_usecase.dart';

part 'room_items_event.dart';
part 'room_items_state.dart';

class RoomItemsBloc extends Bloc<RoomItemsEvent, RoomItemsState> {
  final GetItemsUseForRoomUseCase getItemsUseForRoomUseCase;

  RoomItemsBloc({
    @required this.getItemsUseForRoomUseCase,
  }) : super(RoomItemsInitial());

  @override
  Stream<RoomItemsState> mapEventToState(
    RoomItemsEvent event,
  ) async* {
    if (event is GetRoomItems) {
      yield RoomItemsLoading();

      final itemsResponse = await getItemsUseForRoomUseCase.execute(
        GetItemsUseForRoomParams(roomId: event.roomId),
      );

      yield* itemsResponse.fold((failure) async* {
        yield RoomItemsFailure(failure: failure);
      }, (items) async* {
        yield RoomItemsLoaded(items: items);
      });
    }
  }
}
