// lib/settings_menu.dart
import 'package:flutter/material.dart';

class SettingsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        automaticallyImplyLeading: false, // No default back
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('GRÁFICOS'),
            onTap: () {
              // TODO: Implement submenu if needed later
            },
          ),
          ListTile(
            title: Text('SONIDO'),
            onTap: () {
              // TODO: Implement submenu if needed later
            },
          ),
          ListTile(
            title: Text('INTERFAZ'),
            onTap: () {
              // TODO: Implement submenu if needed later
            },
          ),
          ListTile(
            title: Text('ACCESIBILIDAD'),
            onTap: () {
              // TODO: Implement submenu if needed later
            },
          ),
          ListTile(
            title: Text('DATOS'),
            onTap: () {
              // TODO: Implement submenu if needed later
            },
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('VOLVER'),
            ),
          ),
        ],
      ),
    );
  }
}