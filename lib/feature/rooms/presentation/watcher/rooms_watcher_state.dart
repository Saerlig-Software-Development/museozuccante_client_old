part of 'rooms_watcher_bloc.dart';

abstract class RoomsWatcherState {
  const RoomsWatcherState();
}

class RoomsWatcherInitial extends RoomsWatcherState {}

class RoomsWatcherLoading extends RoomsWatcherState {}

class RoomsWatcherLoadSuccess extends RoomsWatcherState {
  final List<RoomDomainModel> rooms;

  const RoomsWatcherLoadSuccess({
    @required this.rooms,
  });
}

class RoomsWatcherFailure extends RoomsWatcherState {
  final Failure failure;

  RoomsWatcherFailure({@required this.failure});
}
