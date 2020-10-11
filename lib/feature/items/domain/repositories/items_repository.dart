import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/exceptions/successes.dart';
import 'package:museo_zuccante/core/data/generics/resource.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';

abstract class ItemsRepository {
  Stream<Resource<List<ItemDomainModel>>> watchAllItems();

  Future<Either<Failure, Success>> updateItems({@required bool ifNeeded});

  Future<Either<Failure, ItemDomainModel>> getItem(String id);

  Future<Either<Failure, List<ItemDomainModel>>> getItems();
}
