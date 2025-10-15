// lib/challenges_menu.dart
import 'package:flutter/material.dart';

class ChallengesMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desafíos'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('Por ahora no hay desafíos'),
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