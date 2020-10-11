part of 'items_updater_bloc.dart';

abstract class ItemsUpdaterState {
  const ItemsUpdaterState();
}

class ItemsUpdaterInitial extends ItemsUpdaterState {}

class ItemsUpdaterLoading extends ItemsUpdaterState {}

class ItemsUpdaterSuccess extends ItemsUpdaterState {
  final Success success;

  const ItemsUpdaterSuccess({@required this.success});
}

class ItemsUpdaterFailure extends ItemsUpdaterState {
  final Failure failure;

  const ItemsUpdaterFailure({@required this.failure});
}
