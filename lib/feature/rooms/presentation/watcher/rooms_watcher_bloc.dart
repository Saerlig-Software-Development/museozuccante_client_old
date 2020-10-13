import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/generics/resource.dart';
import 'package:museo_zuccante/core/domain/usecase.dart';
import 'package:museo_zuccante/feature/rooms/domain/model/room_domain_model.dart';
import 'package:museo_zuccante/feature/rooms/domain/usecase/watch_rooms_usecase.dart';

part 'rooms_watcher_event.dart';
part 'rooms_watcher_state.dart';

class RoomsWatcherBloc extends Bloc<RoomsWatcherEvent, RoomsWatcherState> {
  final WatchRoomsUseCase watchRoomsUseCase;

  StreamSubscription _roomsStreamSubscription;

  RoomsWatcherBloc({
    @required this.watchRoomsUseCase,
  }) : super(RoomsWatcherInitial()) {
    _roomsStreamSubscription =
        watchRoomsUseCase.execute(NoParams()).listen((resource) {
      add(RoomsReceived(resource: resource));
    });
  }

  @override
  Stream<RoomsWatcherState> mapEventToState(
    RoomsWatcherEvent event,
  ) async* {
    if (event is RoomsReceived) {
      if (event.resource.status == Status.failed) {
        yield RoomsWatcherFailure(failure: event.resource.failure);
      } else if (event.resource.status == Status.success) {
        yield RoomsWatcherLoadSuccess(rooms: event.resource.data);
      } else if (event.resource.status == Status.loading) {
        yield RoomsWatcherLoading();
      }
    }
  }

  @override
  Future<void> close() {
    _roomsStreamSubscription?.cancel();
    return super.close();
  }
}
