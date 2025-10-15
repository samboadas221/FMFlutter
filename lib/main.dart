// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main_menu.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'models/manager.dart';  // Crea este file abajo
import 'models/player.dart';   // Crea este file abajo
import 'models/team.dart';     // Crea este file abajo

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();  // Init Hive
  Hive.registerAdapter(ManagerAdapter());  // Registra adapters
  Hive.registerAdapter(PlayerAdapter());
  Hive.registerAdapter(TeamAdapter());
  // Abre boxes globales (e.g., uno por tipo de data)
  await Hive.openBox<Manager>('managers');
  await Hive.openBox<Player>('players');
  await Hive.openBox<Team>('teams');
  // Resto de tu main..
  // Hide system UI for immersion
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  
  // Lock orientation to portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Manager Simulator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}
flutter pub run build_runner build --delete-conflicting-outputs
