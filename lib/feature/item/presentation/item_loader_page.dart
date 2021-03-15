import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/feature/item/presentation/item_page.dart';

import 'bloc/item_bloc.dart';

class ItemLoaderPage extends StatefulWidget {
  final String id;

  ItemLoaderPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  _ItemLoaderPageState createState() => _ItemLoaderPageState();
}

class _ItemLoaderPageState extends State<ItemLoaderPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ItemBloc>(context).add(GetItem(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoaded) {
            return ItemPage(item: state.item);
          } else if (state is ItemNotFound) {
            return Text("Not found");
          } else if (state is ItemFailure) {
            return Text("Failure");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
