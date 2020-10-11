import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/exceptions/successes.dart';
import 'package:museo_zuccante/core/domain/usecase.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';

class GetItemUseCase implements UseCase<ItemDomainModel, GetItemParams> {
  final ItemsRepository itemsRepository;

  GetItemUseCase({
    @required this.itemsRepository,
  });

  @override
  Future<Either<Failure, ItemDomainModel>> execute(GetItemParams params) {
    return itemsRepository.getItem(params.id);
  }
}

class GetItemParams {
  final String id;

  GetItemParams({@required this.id});
}
