// lib/main_menu.dart
import 'package:flutter/material.dart';
import 'play_menu.dart';
import 'settings_menu.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
        automaticallyImplyLeading: false, // No back button here
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayMenu()),
                GeneratedPluginRegistrant
                );
              },
              onLongPress: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute
                      (builder: (context) => DebugScreen())
                  );
              },
              child: Text('JUGAR'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsMenu()),
                );
              },
              child: Text('AJUSTES'),
            ),
          ],
        ),
      ),
    );
  }
}