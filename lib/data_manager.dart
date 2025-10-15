// lib/data_manager.dart
import 'package:hive/hive.dart';
import 'models/manager.dart';  // Asume que creaste este model como en mi respuesta anterior
import 'models/team.dart';    // Similar, para teams/ligas

class DataManager {
  static Future<void> initializeData() async {
    // Abre boxes necesarios
    var managersBox = Hive.box<Manager>('managers');
    var teamsBox = Hive.box<Team>('teams');

    // Check si datos de ligas/equipos existen; si no, inicializa
    if (teamsBox.isEmpty) {
      // Inicializa ligas y equipos dummy
      var englandTeams = [
        Team(id: 'liverpool', name: 'Liverpool', league: 'Inglaterra', playerIds: []),
        Team(id: 'watford', name: 'Watford', league: 'Inglaterra', playerIds: []),
      ];
      var spainTeams = [
        Team(id: 'osasuna', name: 'Osasuna', league: 'España', playerIds: []),
        Team(id: 'bilbao', name: 'Bilbao', league: 'España', playerIds: []),
      ];

      // Guarda en box
      for (var team in englandTeams + spainTeams) {
        await teamsBox.put(team.id, team);
      }
    }
  }

  static Future<void> saveManager(Manager manager) async {
    var box = Hive.box<Manager>('managers');
    await box.put('current_manager', manager);  // Usa key simple para el manager actual
  }

  static Future<Manager?> loadManager() async {
    var box = Hive.box<Manager>('managers');
    return box.get('current_manager');
  }

  // Método para cargar ligas/equipos (usado en el menú)
  static Map<String, List<String>> getLeaguesAndTeams() {
    var teamsBox = Hive.box<Team>('teams');
    Map<String, List<String>> leagues = {};
    for (var team in teamsBox.values) {
      leagues.putIfAbsent(team.league, () => []);
      leagues[team.league]!.add(team.name);
    }
    return leagues;
  }

  // Agrega más métodos según necesites, e.g., para players más adelante
}