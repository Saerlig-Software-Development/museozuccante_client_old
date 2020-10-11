import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/data/exceptions/successes.dart';
import 'package:museo_zuccante/core/presentation/generic_failure_state.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_loaded.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_loading.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/watcher/items_watcher_bloc.dart';

class ItemsPage extends StatefulWidget {
  final goToList;

  ItemsPage({
    Key key,
    @required this.goToList,
  }) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  void initState() {
    super.initState();

    updateItemsIfNeeded();
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
            if (state is ItemsWatcherLoadSuccess) {
              if (state.items.length == 0) {
                return ItemsLoadingState();
              }

              // return SafeArea(
              //     child: Text(state.items.map((e) => e.title).toString()));

              return ItemsLoadedState(
                items: state.items,
                goToList: widget.goToList,
              );
            } else if (state is ItemsWatcherFailure) {
              return GenericFailureState(
                failure: state.failure,
                onTap: updateItems,
              );
            }
            return ItemsLoadingState();
          },
        ),
      ),
    );
  }

  void updateItems() {
    context.bloc<ItemsUpdaterBloc>().add(UpdateItems());
  }

  void updateItemsIfNeeded() {
    context.bloc<ItemsUpdaterBloc>().add(UpdateItemsIfNeeded());
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
