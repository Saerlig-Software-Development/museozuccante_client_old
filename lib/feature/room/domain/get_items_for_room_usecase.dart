import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/domain/usecase.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';

class GetItemsUseForRoomUseCase
    implements UseCase<List<ItemDomainModel>, GetItemsUseForRoomParams> {
  final ItemsRepository itemsRepository;

  GetItemsUseForRoomUseCase({
    @required this.itemsRepository,
  });

  @override
  Future<Either<Failure, List<ItemDomainModel>>> execute(
      GetItemsUseForRoomParams params) {
    return itemsRepository.getRoomItems(roomId: params.roomId);
  }
}

class GetItemsUseForRoomParams {
  final String roomId;

  GetItemsUseForRoomParams({@required this.roomId});
}
