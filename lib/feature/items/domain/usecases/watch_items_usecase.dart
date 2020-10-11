import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/generics/resource.dart';
import 'package:museo_zuccante/core/domain/usecase.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';

class WatchItemsUseCase
    implements StreamUseCase<List<ItemDomainModel>, NoParams> {
  final ItemsRepository itemsRepository;

  WatchItemsUseCase({
    @required this.itemsRepository,
  });

  @override
  Stream<Resource<List<ItemDomainModel>>> execute(NoParams params) {
    return itemsRepository.watchAllItems();
  }
}
