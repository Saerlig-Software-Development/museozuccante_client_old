import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/exceptions/successes.dart';
import 'package:museo_zuccante/feature/rooms/domain/usecase/update_rooms_usecase.dart';

part 'rooms_updater_event.dart';
part 'rooms_updater_state.dart';

class RoomsUpdaterBloc extends Bloc<RoomsUpdaterEvent, RoomsUpdaterState> {
  UpdateRoomsUseCase updateRoomsUseCase;

  RoomsUpdaterBloc({
    @required this.updateRoomsUseCase,
  }) : super(RoomsUpdaterInitial());

  @override
  Stream<RoomsUpdaterState> mapEventToState(
    RoomsUpdaterEvent event,
  ) async* {
    if (event is UpdateRoomsIfNeeded) {
      yield RoomsUpdaterLoading();

      final update = await updateRoomsUseCase.execute(
        UpdateRoomsParams(ifNeeded: true),
      );

      yield* update.fold((failure) async* {
        yield RoomsUpdaterFailure(failure: failure);
      }, (success) async* {
        yield RoomsUpdaterSuccess(success: success);
      });
    } else if (event is UpdateRooms) {
      yield RoomsUpdaterLoading();

      final update = await updateRoomsUseCase.execute(
        UpdateRoomsParams(ifNeeded: false),
      );

      yield* update.fold((failure) async* {
        yield RoomsUpdaterFailure(failure: failure);
      }, (success) async* {
        yield RoomsUpdaterSuccess(success: success);
      });
    }
  }
}
