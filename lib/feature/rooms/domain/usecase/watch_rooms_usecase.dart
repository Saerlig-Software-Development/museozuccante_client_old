import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/generics/resource.dart';
import 'package:museo_zuccante/core/domain/usecase.dart';
import 'package:museo_zuccante/feature/rooms/domain/model/room_domain_model.dart';
import 'package:museo_zuccante/feature/rooms/domain/repository/rooms_repository.dart';

class WatchRoomsUseCase
    implements StreamUseCase<List<RoomDomainModel>, NoParams> {
  final RoomsRepository roomsRepository;

  WatchRoomsUseCase({
    @required this.roomsRepository,
  });

  @override
  Stream<Resource<List<RoomDomainModel>>> execute(NoParams params) {
    return roomsRepository.watchAllRooms();
  }
}
