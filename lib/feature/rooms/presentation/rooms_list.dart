import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/presentation/generic_failure_state.dart';
import 'package:museo_zuccante/feature/rooms/presentation/state/rooms_loaded.dart';
import 'package:museo_zuccante/feature/rooms/presentation/updater/rooms_updater_bloc.dart';
import 'package:museo_zuccante/feature/rooms/presentation/watcher/rooms_watcher_bloc.dart';

class RoomsList extends StatefulWidget {
  RoomsList({Key key}) : super(key: key);

  @override
  _RoomsListState createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {
  @override
  void initState() {
    super.initState();

    print("Watch all started");
    context.bloc<RoomsWatcherBloc>().add(WatchAllStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RoomsWatcherBloc, RoomsWatcherState>(
        listener: (context, state) {
          if (state is RoomsWatcherLoadSuccess && state.rooms.length == 0) {
            updateRooms();
          }
        },
        builder: (context, state) {
          if (state is RoomsWatcherLoadSuccess) {
            // return Text(state.rooms.length.toString());
            if (state.rooms.length == 0) {
              return buildLoading();
            }

            return RoomsLoaded(rooms: state.rooms);
          } else if (state is RoomsWatcherFailure) {
            return GenericFailureState(
              failure: state.failure,
              onTap: updateRooms,
            );
          }

          return buildLoading();
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void updateRooms() {
    context.bloc<RoomsUpdaterBloc>().add(UpdateRooms());
  }
}
