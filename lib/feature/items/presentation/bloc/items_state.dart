part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

class ItemsInitial extends ItemsState {}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<ItemDomainModel> items;

  ItemsLoaded({
    @required this.items,
  });
}

class ItemsFailure extends ItemsState {
  final Failure failure;

  ItemsFailure({@required this.failure});
}
