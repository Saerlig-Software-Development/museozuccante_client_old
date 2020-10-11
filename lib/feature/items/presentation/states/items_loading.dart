import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/core/presentation/custom_shimmer.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';

class ItemsLoadingState extends StatelessWidget {
  const ItemsLoadingState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ItemsUpdaterBloc>(context).add(UpdateItems());
      },
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildLoadingSearchBar(),
          buildTopVisitedSection(),
          buildLoadingNewsAndExibitions()
        ],
      ),
    );
  }

  Widget buildLoadingNewsAndExibitions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CustomShimmer(
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: EdgeInsets.zero,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildTopVisitedSection() {
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
                // color: ,
                onPressed: () {},
                child: Text(
                  "View all",
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
        SizedBox(
          height: 250,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: buildLoadingTopVisitedCard(),
                  );
                } else if (index == 15) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: buildLoadingTopVisitedCard(),
                  );
                }

                return buildLoadingTopVisitedCard();
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoadingTopVisitedCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0.0, 16.0, 8.0),
      child: CustomShimmer(
        child: Container(
          width: 190,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget buildLoadingSearchBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: MZColors.primary,
        // borderRadius: BorderRadius.circular(16.0),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            width: double.infinity,
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
      ),
    );
  }
}
