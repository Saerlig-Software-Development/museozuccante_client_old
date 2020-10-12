part of 'rooms_updater_bloc.dart';

abstract class RoomsUpdaterState {
  const RoomsUpdaterState();
}

class RoomsUpdaterInitial extends RoomsUpdaterState {}

class RoomsUpdaterLoading extends RoomsUpdaterState {}

class RoomsUpdaterSuccess extends RoomsUpdaterState {
  final Success success;

  const RoomsUpdaterSuccess({@required this.success});
}

class RoomsUpdaterFailure extends RoomsUpdaterState {
  final Failure failure;

  const RoomsUpdaterFailure({@required this.failure});
}
