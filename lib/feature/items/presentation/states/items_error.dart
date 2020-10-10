import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';

class ItemsFailureState extends StatelessWidget {
  final Failure failure;

  const ItemsFailureState({
    Key key,
    @required this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(failure.runtimeType.toString()),
    );
  }
}
