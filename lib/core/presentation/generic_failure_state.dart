import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';

class GenericFailureState extends StatelessWidget {
  final Failure failure;
  final GestureTapCallback onTap;

  const GenericFailureState({
    Key key,
    @required this.onTap,
    @required this.failure,
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
              getIcon(),
              size: 80,
              color: MZColors.errorColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              failure.localizedDescription ?? 'Unexcepted error',
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

  IconData getIcon() {
    if (failure is NetworkFailure) {
      return Icons.signal_cellular_connected_no_internet_4_bar;
    } else {
      return Icons.error;
    }
  }
}
