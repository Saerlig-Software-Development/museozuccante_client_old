part of 'items_updater_bloc.dart';

abstract class ItemsUpdaterEvent {
  const ItemsUpdaterEvent();
}

class UpdateItemsIfNeeded extends ItemsUpdaterEvent {}

class UpdateItems extends ItemsUpdaterEvent {}
