import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:museo_zuccante/core/presentation/generic_failure_state.dart';

class CreditsView extends StatelessWidget {
  const CreditsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
      ),
      body: FutureBuilder(
        future: http.get(
            'https://raw.githubusercontent.com/Saerlig-App-Development/museozuccante_client/main/CREDITS.md'),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return Markdown(
              padding: const EdgeInsets.all(16.0),
              data: snapshot.data.body,
            );
          } else if (snapshot.hasError) {
            return GenericFailureState(
              failure: snapshot.error,
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
}
