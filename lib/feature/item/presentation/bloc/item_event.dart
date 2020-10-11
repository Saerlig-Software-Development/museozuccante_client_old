part of 'item_bloc.dart';

abstract class ItemEvent {
  const ItemEvent();
}

class GetItem extends ItemEvent {
  final String id;

  GetItem({
    @required this.id,
  });
}
