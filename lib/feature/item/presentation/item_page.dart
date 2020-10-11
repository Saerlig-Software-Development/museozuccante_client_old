import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:museo_zuccante/core/presentation/image/mz_image.dart';
import 'package:museo_zuccante/core/presentation/shadow_utils.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';

class ItemPage extends StatefulWidget {
  final ItemDomainModel item;
  final bool fromHome;

  ItemPage({
    Key key,
    @required this.item,
    this.fromHome = true,
  }) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  double top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: widget.fromHome
                          ? 'item${widget.item.id}'
                          : 'item-list${widget.item.id}',
                      child: Container(
                        height: 300,
                        padding: EdgeInsets.only(top: max(top, 0)),
                        width: double.infinity,
                        child: MzImage(
                          widget.item.poster,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Container(
                            height: 24,
                            width: 24,
                            child: Icon(Icons.arrow_back_ios_outlined)),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      elevation: 0,
                      // actions: <Widget>[
                      //   Padding(
                      //     padding: const EdgeInsets.only(right: 16.0),
                      //     child: IconButton(
                      //       icon: _bookmarked
                      //           ? Icon(Icons.bookmark)
                      //           : Icon(Icons.bookmark_border),
                      //       onPressed: () {
                      //         setState(() {
                      //           _bookmarked = !_bookmarked;
                      //         });
                      //       },
                      //     ),
                      //   )
                      // ],
                    )
                  ],
                ),
              ),
              FractionalTranslation(
                translation: Offset(0.0, -0.02),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(6.0),
                    ),
                  ),
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -75.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: ShadowUtils.getDefaultShadow(),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.item.subtitle.toUpperCase(),
                                    style: TextStyle(
                                      // color: ,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    widget.item.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  _buildSpacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Markdown(
                                physics: NeverScrollableScrollPhysics(),
                                data: widget.item.body,
                                shrinkWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildSpacer() {
    return Container(
      height: 3,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(32.0),
      ),
    );
  }
}
