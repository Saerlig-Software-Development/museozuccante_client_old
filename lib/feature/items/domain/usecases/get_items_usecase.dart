import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:museo_zuccante/core/domain/usecase.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';

class GetItemsUseCase implements UseCase<List<ItemDomainModel>, NoParams> {
  final ItemsRepository itemsRepository;

  GetItemsUseCase({
    @required this.itemsRepository,
  });

  @override
  Future<Either<Failure, List<ItemDomainModel>>> execute(NoParams params) {
    return itemsRepository.getItems();
  }
}
