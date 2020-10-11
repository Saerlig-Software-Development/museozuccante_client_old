import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/error_handler.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/exceptions/successes.dart';
import 'package:museo_zuccante/core/data/generics/resource.dart';
import 'package:museo_zuccante/core/infrastructure/network_info.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_local_datasource.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_remote_datasource.dart';
import 'package:museo_zuccante/feature/items/data/models/item_local_model.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  static const String LAST_UPDATE_KEY = 'itemsLastUpdate';

  final ItemsRemoteDatasource itemsRemoteDatasource;
  final ItemsLocalDatasource itemsLocalDatasource;

  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  ItemsRepositoryImpl({
    @required this.itemsRemoteDatasource,
    @required this.networkInfo,
    @required this.sharedPreferences,
    @required this.itemsLocalDatasource,
  });

  bool _needUpdate() {
    final lastUpdate = sharedPreferences.getInt(LAST_UPDATE_KEY);
    return lastUpdate == null ||
        DateTime.fromMillisecondsSinceEpoch(lastUpdate)
            .isBefore(DateTime.now().subtract(
          Duration(minutes: 5),
        ));
  }

  @override
  Stream<Resource<List<ItemDomainModel>>> watchAllItems() async* {
    yield* itemsLocalDatasource.watchAllItems().map((localModels) {
      return Resource.success(
          data: localModels
              .map((localModel) => ItemDomainModel.fromLocalModel(localModel))
              .toList());
    }).onErrorReturnWith(
      (e) {
        return Resource.failed(error: e);
      },
    );
  }

  @override
  Future<Either<Failure, Success>> updateItems({bool ifNeeded}) async {
    try {
      if (!ifNeeded | (ifNeeded && _needUpdate())) {
        final remoteItems = await itemsRemoteDatasource.getItems();

        final localItems =
            remoteItems.map((e) => ItemLocalModel.fromRemoteModel(e)).toList();

        await itemsLocalDatasource.insertItems(localItems);

        sharedPreferences.setInt(
            LAST_UPDATE_KEY, DateTime.now().millisecondsSinceEpoch);

        return Right(SuccessWithUpdate());
      }

      return Right(SuccessWithoutUpdate());
    } catch (e) {
      return Left(handleError(e));
    }
  }
}
