import 'package:dio/dio.dart';
import 'package:museo_zuccante/feature/items/data/models/item_remote_model.dart';

class ItemsRemoteDatasource {
  final Dio dio;

  const ItemsRemoteDatasource({
    this.dio,
  });

  Future<List<ItemRemoteModel>> getItems() async {
    final response = await dio.get('/api/item');

    // await Future.delayed(Duration(seconds: 1));
    List<ItemRemoteModel> itemsList = List<ItemRemoteModel>.from(
        response.data.map((i) => ItemRemoteModel.fromJson(i)));

    return itemsList;
  }
}
