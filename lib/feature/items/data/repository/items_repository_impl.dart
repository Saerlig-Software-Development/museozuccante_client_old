import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/error_handler.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/infrastructure/log/logger.dart';
import 'package:museo_zuccante/core/infrastructure/network_info.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_local_datasource.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_remote_datasource.dart';
import 'package:museo_zuccante/feature/items/data/models/item_local_model.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

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

  @override
  Future<Either<Failure, List<ItemDomainModel>>> getItems() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteItems = await itemsRemoteDatasource.getItems();

        return Right(
          remoteItems.map((e) => ItemDomainModel.fromRemoteModel(e)).toList(),
        );
      } on Exception catch (e) {
        return Left(handleError(e));
      } catch (e, s) {
        Logger.e(e, s);
        return Left(GenericFailureWithoutException());
      }
    } else {
      return Left(NotConnectedFailure());
    }
  }

  bool _needUpdate(int lastUpdate) {
    return lastUpdate == null ||
        DateTime.fromMillisecondsSinceEpoch(lastUpdate)
            .isBefore(DateTime.now().subtract(
          Duration(minutes: 5),
        ));
  }

  @override
  Stream watchAllItems() async* {
    yield* itemsLocalDatasource.watchAllItems().map((localModels) {
      return right<Failure, List<ItemDomainModel>>(
        (localModels
            .map((localModel) => ItemDomainModel.fromLocalModel(localModel))
            .toList()),
      );
    }).onErrorReturnWith(
      (e) {
        return left<Failure, List<ItemDomainModel>>(handleError(e));
      },
    ).doOnEach((notification) async {
      final lastUpdate = sharedPreferences.getInt(LAST_UPDATE_KEY);

      if (_needUpdate(lastUpdate)) {
        Logger.info('Need to update, procceding!');

        final remoteItems = await itemsRemoteDatasource.getItems();

        final localItems =
            remoteItems.map((e) => ItemLocalModel.fromRemoteModel(e)).toList();

        await itemsLocalDatasource.insertItems(localItems);

        sharedPreferences.setInt(
            LAST_UPDATE_KEY, DateTime.now().millisecondsSinceEpoch);
      } else {
        Logger.info('No eed to update');
      }
    });
  }

  @override
  Future updateItems() async {
    final remoteItems = await itemsRemoteDatasource.getItems();

    final localItems =
        remoteItems.map((e) => ItemLocalModel.fromRemoteModel(e)).toList();

    await itemsLocalDatasource.insertItems(localItems);

    sharedPreferences.setInt(
        LAST_UPDATE_KEY, DateTime.now().millisecondsSinceEpoch);
  }
}
