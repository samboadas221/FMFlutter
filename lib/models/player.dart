import 'package:hive/hive.dart';

part 'player.g.dart';

@HiveType(typeId: 1)
class Player extends HiveObject {
  @HiveField(0) String name;
  @HiveField(1) String surname;
  @HiveField(2) int speed;  // Ejemplo stat
  @HiveField(3) int passAccuracy;
  @HiveField(4) String teamId;  // Referencia a team
  @HiveField(5) Map<String, dynamic> contract;  // {salary: 100000, years: 3, clauses: []}
  Player({required this.name, required this.surname, required this.speed, required this.passAccuracy, required this.teamId, required this.contract});
}