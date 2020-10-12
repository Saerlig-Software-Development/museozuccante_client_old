import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/core/presentation/image/mz_image.dart';
import 'package:museo_zuccante/core/presentation/no_glow_behavior.dart';
import 'package:museo_zuccante/feature/item/presentation/item_page.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/presentation/search/search_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/states/widget/item_vertical_card.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
import 'package:museo_zuccante/feature/qrcode/presentation/dialog/animated_qr_dialog.dart';

class ItemsLoadedState extends StatefulWidget {
  final List<ItemDomainModel> items;
  final goToList;

  const ItemsLoadedState({
    Key key,
    @required this.items,
    @required this.goToList,
  }) : super(key: key);

  @override
  _ItemsLoadedStateState createState() => _ItemsLoadedStateState();
}

class _ItemsLoadedStateState extends State<ItemsLoadedState> {
  TextEditingController _searchController;
  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _searchController.addListener(() {
      context.bloc<SearchBloc>().add(SearchItem(query: _searchController.text));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildSearchBar(),
                if (_searchController.text.length < 2)
                  buildTopVisitedSection(
                      items: widget.items
                          .where((element) => element.highlighted)
                          .toList()),
                if (_searchController.text.length < 2)
                  buildsAndExibitions(
                      items: widget.items
                          .where((element) => !element.highlighted)
                          .toList()),
                if (_searchController.text.length >= 2) buildResults()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResults() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchResultsLoaded) {
          return buildsAndExibitions(items: state.results, search: true);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: MZColors.primary,
        // borderRadius: BorderRadius.circular(16.0),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      Flexible(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 15,
                              bottom: 11,
                              top: 11,
                              right: 15,
                            ),
                            hintText: 'Search an item',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Material(
                borderRadius: BorderRadius.circular(8.0),
                child: Ink(
                  decoration: BoxDecoration(
                    color: MZColors.alternativeBackgroundColor,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AnimatedQRDialog(),
                      );
                    },
                    child: Hero(
                      tag: 'qrcode',
                      child: Container(
                        padding: EdgeInsets.all(13.0),
                        decoration: BoxDecoration(
                          // color: MZColors.alternativeBackgroundColor,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Icon(
                          CupertinoIcons.qrcode_viewfinder,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildsAndExibitions({
    @required List<ItemDomainModel> items,
    bool search = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (search)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Text(
              'Results',
              style: TextStyle(
                fontSize: 18,
                color: MZColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (!search)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Text(
              'News and exibitions',
              style: TextStyle(
                fontSize: 18,
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

            return ItemVerticalCard(item: item);
          },
        ),
      ],
    );
  }

  Widget buildTopVisitedSection({
    @required List<ItemDomainModel> items,
  }) {
    // return Text(items.map((e) => e.title).toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Row(
            children: [
              Text(
                'Top visited',
                style: TextStyle(
                  fontSize: 18,
                  color: MZColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  widget.goToList();
                },
                child: Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 16,
                    color: MZColors.primary,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Text(items.map((e) => e.title).toString()),
        SizedBox(
          height: 250,
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: buildTopVisitedCard(item: item),
                    );
                  } else if (index == 15) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: buildTopVisitedCard(item: item),
                    );
                  }

                  return buildTopVisitedCard(item: item);
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTopVisitedCard({
    @required ItemDomainModel item,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0.0, 16.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              goToItemPage(item);
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).cardColor.withOpacity(0.9),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Hero(
                          tag: 'item${item.id}',
                          child: MzImage(item.poster),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      item.title,
                      style: TextStyle(
                        // fontWeight: FontWeight.w200,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      item.subtitle,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.place,
                          size: 15,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          item.room.title,
                          style: TextStyle(
                            color: MZColors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    )
                  ],
                ),
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
}
