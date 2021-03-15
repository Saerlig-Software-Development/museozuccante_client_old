import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';

class EmptyView extends StatelessWidget {
  final GestureTapCallback onTap;

  const EmptyView({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Icon(
              Icons.hourglass_empty,
              color: MZColors.lightGrey,
              size: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Empty here',
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            child: Text(
              'Retry',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            onPressed: onTap,
          )
        ],
      ),
    );
  }
}
