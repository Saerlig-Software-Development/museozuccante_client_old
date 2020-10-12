import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/feature/items/presentation/items_list_page.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
import 'package:museo_zuccante/feature/rooms/presentation/rooms_list.dart';
import 'package:museo_zuccante/feature/rooms/presentation/updater/rooms_updater_bloc.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        backgroundColor: MZColors.primary,
        color: Colors.white,
        onRefresh: () async {
          BlocProvider.of<ItemsUpdaterBloc>(context).add(UpdateItems());
          BlocProvider.of<RoomsUpdaterBloc>(context).add(UpdateRooms());
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemsListPage(
                    rooms: RoomsList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
