import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:museo_zuccante/core/core_container.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/feature/navigator/navigator_page.dart';

void main() async {
  // Before dependency injection, for shared preferences
  WidgetsFlutterBinding.ensureInitialized();

  // Wait for dependency injection
  await CoreContainer.init();

  // trasparent status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // statusBarBrightness: Brightness.dark,
  ));

  runApp(
    MultiRepositoryProvider(
      providers: CoreContainer.getRepositoryProviders(),
      child: MultiBlocProvider(
        providers: CoreContainer.getBlocProviders(),
        child: MuseumApp(),
      ),
    ),
  );
}

class MuseumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Museo Zuccante',
      theme: ThemeData(
        accentColor: MZColors.primary,
        textTheme: GoogleFonts.varelaRoundTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: MZColors.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
      ),
      home: NavigatorPage(),
    );
  }
}
