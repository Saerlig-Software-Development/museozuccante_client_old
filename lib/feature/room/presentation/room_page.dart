import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/presentation/generic_failure_state.dart';
import 'package:museo_zuccante/feature/item/presentation/item_page.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/presentation/states/widget/item_vertical_card.dart';
import 'package:museo_zuccante/feature/room/presentation/bloc/room_items_bloc.dart';

class RoomPage extends StatefulWidget {
  final String name;
  final String roomId;

  RoomPage({
    Key key,
    @required this.roomId,
    @required this.name,
  }) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void initState() {
    super.initState();
    context.bloc<RoomItemsBloc>().add(GetRoomItems(roomId: widget.roomId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: BlocBuilder<RoomItemsBloc, RoomItemsState>(
        builder: (context, state) {
          if (state is RoomItemsLoaded) {
            if (state.items.length != 0) {
              return buildItemsList(items: state.items);
            }
          } else if (state is RoomItemsFailure) {
            return GenericFailureState(
              failure: state.failure,
              onTap: () {},
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildItemsList({
    @required List<ItemDomainModel> items,
  }) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemVerticalCard(
          item: item,
          fromHome: false,
        );
      },
    );
  }

  void goToItemPage(ItemDomainModel itemDomainModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ItemPage(
          item: itemDomainModel,
        ),
      ),
    );
  }
}
