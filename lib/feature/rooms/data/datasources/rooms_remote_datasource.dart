import 'package:dio/dio.dart';
import 'package:museo_zuccante/feature/rooms/data/models/room_remote_model.dart';

class RoomsRemoteDatasource {
  final Dio dio;

  const RoomsRemoteDatasource({
    this.dio,
  });

  Future<List<RoomRemoteModel>> getRooms() async {
    final response = await dio.get('/api/rooms');

    List<RoomRemoteModel> itemsList = List<RoomRemoteModel>.from(
        response.data.map((i) => RoomRemoteModel.fromJson(i)));

    return itemsList;
  }
}
