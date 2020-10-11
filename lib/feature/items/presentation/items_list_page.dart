import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_local_datasource.dart';
import 'package:museo_zuccante/feature/items/data/models/item_local_model.dart';
import 'package:museo_zuccante/feature/items/presentation/watcher/items_watcher_bloc.dart';

import '../items_container.dart';

class ItemsListPage extends StatefulWidget {
  ItemsListPage({Key key}) : super(key: key);

  @override
  _ItemsListPageState createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  @override
  void initState() {
    super.initState();

    watchAllItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BlocBuilder<ItemsWatcherBloc, ItemsWatcherState>(
            builder: (context, state) {
              if (state is ItemsWatcherLoadSuccess) {
                return Text(state.items.toString());
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  void watchAllItems() {
    context.bloc<ItemsWatcherBloc>().add(WatchAllStarted());
  }
}
