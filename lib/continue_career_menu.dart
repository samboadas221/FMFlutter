// lib/continue_career_menu.dart
import 'package:flutter/material.dart';

class ContinueCareerMenu extends StatelessWidget {
  final List<String> _saves = ['Real Madrid', 'Primo Juan', 'Tranmere Rovers', 'FC Barcelona'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Continuar Carrera'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _saves.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_saves[index]),
            onTap: () {
              // TODO: Load save, for now does nothing
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('VOLVER'),
        ),
      ),
    );
  }
}