import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_error.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_loaded.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_loading.dart';
import 'package:museo_zuccante/feature/items/presentation/watcher/items_watcher_bloc.dart';

class ItemsPage extends StatefulWidget {
  ItemsPage({Key key}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ItemsWatcherBloc, ItemsWatcherState>(
        builder: (context, state) {
          if (state is ItemsWatcherLoadSuccess) {
            return ItemsLoadedState(items: state.items);
          } else if (state is ItemsWatcherFailure) {
            return ItemsFailureState(failure: state.failure);
          }
          return ItemsLoadingState();
        },
      ),
      // body: BlocBuilder<ItemsBloc, ItemsState>(
      //   builder: (context, state) {
      //     // return ItemsLoadingState();

      //     if (state is ItemsFailure) {
      //       return ItemsFailureState(failure: state.failure);
      //     } else if (state is ItemsLoaded) {
      //       return ItemsLoadedState(items: state.items);
      //     }

      //     return ItemsLoadingState();
      //   },
      // ),
    );
  }
}
