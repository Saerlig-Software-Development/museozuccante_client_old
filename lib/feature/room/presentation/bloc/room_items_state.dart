part of 'room_items_bloc.dart';

abstract class RoomItemsState {
  const RoomItemsState();
}

class RoomItemsInitial extends RoomItemsState {}

class RoomItemsLoading extends RoomItemsState {}

class RoomItemsLoaded extends RoomItemsState {
  final List<ItemDomainModel> items;

  RoomItemsLoaded({
    @required this.items,
  });
}

class RoomItemsFailure extends RoomItemsState {
  final Failure failure;

  RoomItemsFailure({
    @required this.failure,
  });
}
