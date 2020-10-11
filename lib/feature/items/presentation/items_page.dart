import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/data/exceptions/successes.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_error.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_loaded.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_loading.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
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

    context.bloc<ItemsUpdaterBloc>().add(UpdateItemsIfNeeded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ItemsUpdaterBloc, ItemsUpdaterState>(
        listener: (context, state) {
          reactToUpdaterState(state);
        },
        child: BlocBuilder<ItemsWatcherBloc, ItemsWatcherState>(
          builder: (context, state) {
            return ItemsFailureState(failure: Failure());

            if (state is ItemsWatcherLoadSuccess) {
              return ItemsLoadedState(items: state.items);
            } else if (state is ItemsWatcherFailure) {
              return ItemsFailureState(failure: state.failure);
            }
            return ItemsLoadingState();
          },
        ),
      ),
    );
  }

  void reactToUpdaterState(ItemsUpdaterState state) {
    if (state is ItemsUpdaterFailure) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(state.failure.localizedDescription),
      ));
    } else if (state is ItemsUpdaterSuccess &&
        state.success is SuccessWithUpdate) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Aggiornato'),
      ));
    }
  }
}
