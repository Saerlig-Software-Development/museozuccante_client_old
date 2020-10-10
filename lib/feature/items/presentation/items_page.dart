import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_error.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_loaded.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_loading.dart';

import 'bloc/items_bloc.dart';

class ItemsPage extends StatefulWidget {
  ItemsPage({Key key}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  void initState() {
    super.initState();

    requestItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          if (state is ItemsFailure) {
            return ItemsFailureState(failure: state.failure);
          } else if (state is ItemsLoaded) {
            return ItemsLoadedState(items: state.items);
          }

          return ItemsLoadingState();
        },
      ),
    );
  }

  void requestItems() {
    context.bloc<ItemsBloc>().add(GetItems());
  }
}
