part of 'items_watcher_bloc.dart';

abstract class ItemsWatcherState {
  const ItemsWatcherState();
}

class ItemsWatcherInitial extends ItemsWatcherState {}

class ItemsWatcherLoading extends ItemsWatcherState {}

class ItemsWatcherLoadSuccess extends ItemsWatcherState {
  final List<ItemDomainModel> items;

  ItemsWatcherLoadSuccess({
    @required this.items,
  });
}

class ItemsWatcherFailure extends ItemsWatcherState {
  final Failure failure;

  ItemsWatcherFailure({@required this.failure});
}
