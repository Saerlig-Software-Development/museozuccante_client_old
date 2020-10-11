import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/exceptions/successes.dart';
import 'package:museo_zuccante/core/domain/usecase.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';

class UpdateItemsUseCase implements UseCase<Success, UpdateItemsParams> {
  final ItemsRepository itemsRepository;

  UpdateItemsUseCase({
    @required this.itemsRepository,
  });

  @override
  Future<Either<Failure, Success>> execute(UpdateItemsParams params) {
    return itemsRepository.updateItems(ifNeeded: params.ifNeeded);
  }
}

class UpdateItemsParams {
  final bool ifNeeded;

  UpdateItemsParams({@required this.ifNeeded});
}
