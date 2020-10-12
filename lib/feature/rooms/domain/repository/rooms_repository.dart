import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/exceptions/successes.dart';
import 'package:museo_zuccante/core/data/generics/resource.dart';
import 'package:museo_zuccante/feature/rooms/domain/model/room_domain_model.dart';

abstract class RoomsRepository {
  Stream<Resource<List<RoomDomainModel>>> watchAllRooms();

  Future<Either<Failure, Success>> updateRooms({@required bool ifNeeded});
}
