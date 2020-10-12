part of 'rooms_watcher_bloc.dart';

abstract class RoomsWatcherEvent {
  const RoomsWatcherEvent();
}

class WatchAllStarted extends RoomsWatcherEvent {}

class RoomsReceived extends RoomsWatcherEvent {
  final Resource<List<RoomDomainModel>> resource;

  RoomsReceived({
    @required this.resource,
  });
}
