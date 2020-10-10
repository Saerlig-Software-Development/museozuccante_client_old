import 'package:dartz/dartz.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';

abstract class ItemsRepository {
  Future<Either<Failure, List<ItemDomainModel>>> getItems();
}
