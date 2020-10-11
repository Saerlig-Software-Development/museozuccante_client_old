import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/core/presentation/image/mz_image.dart';
import 'package:museo_zuccante/feature/item/presentation/item_page.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';

class ItemVerticalCard extends StatefulWidget {
  final ItemDomainModel item;
  final bool fromHome;

  ItemVerticalCard({
    Key key,
    @required this.item,
    this.fromHome = true,
  }) : super(key: key);

  @override
  _ItemVerticalCardState createState() => _ItemVerticalCardState();
}

class _ItemVerticalCardState extends State<ItemVerticalCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
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
        margin: EdgeInsets.zero,
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              goToItemPage(widget.item);
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Hero(
                          tag: widget.fromHome
                              ? 'item${widget.item.id}'
                              : 'item-list${widget.item.id}',
                          child: MzImage(
                            widget.item.poster,
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 2,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     child: Hero(
                    //       tag: 'item${widget.item.id}',
                    //       child: MzImage(
                    //         widget.item.poster,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.item.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(widget.item.subtitle),
                          SizedBox(
                            height: 8,
                          ),
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
                                widget.item.room.title,
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
                    // IconButton(
                    //   icon: Icon(widget.item.bookmarked ?? false
                    //       ? Icons.bookmark
                    //       : Icons.bookmark_border),
                    //   onPressed: () {
                    //     final ItemsLocalDatasource datasource = sl();
                    //     datasource.bookmarkItem(widget.item.id);
                    //   },
                    // )
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
          fromHome: widget.fromHome,
        ),
      ),
    );
  }
}
