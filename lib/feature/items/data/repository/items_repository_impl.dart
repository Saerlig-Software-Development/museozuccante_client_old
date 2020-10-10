import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/error_handler.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/infrastructure/log/logger.dart';
import 'package:museo_zuccante/core/infrastructure/network_info.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_remote_datasource.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  final ItemsRemoteDatasource itemsRemoteDatasource;
  final NetworkInfo networkInfo;

  ItemsRepositoryImpl({
    @required this.itemsRemoteDatasource,
    @required this.networkInfo,
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
}
