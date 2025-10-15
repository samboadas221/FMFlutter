// lib/play_menu.dart
import 'package:flutter/material.dart';
import 'new_career_menu.dart';
import 'continue_career_menu.dart';
import 'challenges_menu.dart';

class PlayMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jugar'),
        automaticallyImplyLeading: false, // No default back
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewCareerMenu()),
                );
              },
              child: Text('NUEVA CARRERA'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContinueCareerMenu()),
                );
              },
              child: Text('CONTINUAR CARRERA'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengesMenu()),
                );
              },
              child: Text('DESAFÍOS'),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('VOLVER'),
            ),
          ],
        ),
      ),
    );
  }
}