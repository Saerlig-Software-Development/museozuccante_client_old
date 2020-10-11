import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/presentation/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 24,
                    color: MZColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text('Cancel local data'),
                subtitle:
                    Text('Erase all the downloaded data of the application'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Theme'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Theme'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Informations about the app'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Credits'),
                subtitle: Text('Who made the app'),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
