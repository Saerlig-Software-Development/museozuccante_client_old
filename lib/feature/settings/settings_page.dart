import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/core_container.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_local_datasource.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
import 'package:museo_zuccante/feature/rooms/data/datasources/rooms_local_datasource.dart';
import 'package:museo_zuccante/feature/rooms/presentation/updater/rooms_updater_bloc.dart';
import 'package:museo_zuccante/feature/settings/views/credits_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 24,
                    color: MZColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text('Cancel local data'),
                subtitle:
                    Text('Erase all the downloaded data of the application'),
                onTap: () async {
                  final ItemsLocalDatasource itemsDao = sl();
                  await itemsDao.deleteAllItems();

                  final RoomsLocalDatasource roomsDao = sl();
                  await roomsDao.deleteAllRooms();

                  BlocProvider.of<ItemsUpdaterBloc>(context).add(UpdateItems());
                  BlocProvider.of<RoomsUpdaterBloc>(context).add(UpdateRooms());
                },
              ),
              ListTile(
                title: Text('Informations about the app'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AboutDialog(
                        applicationIcon: Icon(Icons.museum_rounded),
                        applicationVersion: '0.0.1',
                        children: [
                          Text("All rights reserved"),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                title: Text('Credits'),
                subtitle: Text('Who made the app'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return CreditsView();
                    }),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
