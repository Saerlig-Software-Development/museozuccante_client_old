import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/core/presentation/generic_failure_state.dart';
import 'package:museo_zuccante/feature/item/presentation/item_page.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/presentation/states/widget/item_vertical_card.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/watcher/items_watcher_bloc.dart';

class ItemsListPage extends StatefulWidget {
  ItemsListPage({Key key}) : super(key: key);

  @override
  _ItemsListPageState createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
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
            return buildLoaded(items: state.items);
          } else if (state is ItemsWatcherFailure) {
            return GenericFailureState(
              failure: state.failure,
              onTap: updateItems,
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget buildLoaded({
    @required List<ItemDomainModel> items,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        backgroundColor: MZColors.primary,
        color: Colors.white,
        onRefresh: () async {
          context.bloc<ItemsUpdaterBloc>().add(UpdateItems());
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    child: Text(
                      'All exibitions',
                      style: TextStyle(
                        fontSize: 24,
                        color: MZColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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

  void updateItems() {
    context.bloc<ItemsUpdaterBloc>().add(UpdateItems());
  }
}
