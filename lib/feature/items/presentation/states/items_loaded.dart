import 'package:flutter/material.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';

class ItemsLoadedState extends StatelessWidget {
  final List<ItemDomainModel> items;

  const ItemsLoadedState({
    Key key,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(items.toString()),
    );
  }
}
