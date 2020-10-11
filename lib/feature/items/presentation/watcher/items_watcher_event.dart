part of 'items_watcher_bloc.dart';

abstract class ItemsWatcherEvent {
  const ItemsWatcherEvent();
}

class WatchAllStarted extends ItemsWatcherEvent {}

class ItemsReceived extends ItemsWatcherEvent {
  // final Either<Failure, List<ItemDomainModel>> failureOrItems;
  final Resource<List<ItemDomainModel>> resource;

  ItemsReceived({
    @required this.resource,
  });
}
