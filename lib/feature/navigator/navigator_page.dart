import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';
import 'package:museo_zuccante/feature/items/presentation/items_page.dart';

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
          ItemsPage(),
          Scaffold(),
          Scaffold(),
        ],
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: MZColors.primary,
      // unselectedItemColor: CYColors.lightText,
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
          // title: Container(),
          label: '',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          // title: Container(),
          label: '',
          icon: Icon(Icons.list),
        ),
        BottomNavigationBarItem(
          // title: Container(),
          label: '',
          icon: Icon(Icons.map),
        ),
      ],
    );
  }
}
