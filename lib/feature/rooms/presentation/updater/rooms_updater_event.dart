part of 'rooms_updater_bloc.dart';

abstract class RoomsUpdaterEvent {
  const RoomsUpdaterEvent();
}

class UpdateRoomsIfNeeded extends RoomsUpdaterEvent {}

class UpdateRooms extends RoomsUpdaterEvent {}
