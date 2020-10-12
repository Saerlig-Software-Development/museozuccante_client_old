part of 'room_items_bloc.dart';

abstract class RoomItemsEvent {
  const RoomItemsEvent();
}

class GetRoomItems extends RoomItemsEvent {
  final String roomId;

  GetRoomItems({
    @required this.roomId,
  });
}
