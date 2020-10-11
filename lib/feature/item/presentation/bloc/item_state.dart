part of 'item_bloc.dart';

abstract class ItemState {
  const ItemState();
}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final ItemDomainModel item;

  ItemLoaded({@required this.item});
}

class ItemFailure extends ItemState {
  final Failure failure;

  ItemFailure({@required this.failure});
}

class ItemNotFound extends ItemState {}
