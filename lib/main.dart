import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/core_container.dart';
import 'package:museo_zuccante/feature/items/presentation/items_page.dart';

void main() async {
  // Before dependency injection, for shared preferences
  WidgetsFlutterBinding.ensureInitialized();

  // Wait for dependency injection
  await CoreContainer.init();

  runApp(
    MultiBlocProvider(
      providers: CoreContainer.getBlocProviders(),
      child: MuseumApp(),
    ),
  );
}

class MuseumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Museo Zuccante',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ItemsPage(),
    );
  }
}
