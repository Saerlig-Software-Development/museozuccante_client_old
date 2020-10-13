import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/feature/items/presentation/items_page.dart';
import 'package:museo_zuccante/feature/list/list_page.dart';
import 'package:museo_zuccante/feature/map/presentation/map_page.dart';
import 'package:museo_zuccante/feature/settings/settings_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key key}) : super(key: key);

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ItemsPage(
            goToList: () {
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          ListPage(),
          MapPage(),
          SettingsPage(),
          // Text("dssda")
        ],
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: MZColors.primary,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.list),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.map),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
