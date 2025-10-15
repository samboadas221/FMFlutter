import 'package:hive/hive.dart';

part 'team.g.dart';

@HiveType(typeId: 2)
class Team extends HiveObject {
  @HiveField(0) String id;  // Unique, e.g., 'liverpool'
  @HiveField(1) String name;
  @HiveField(2) String league;
  @HiveField(3) List<String> playerIds;  // Referencias a players
  Team({required this.id, required this.name, required this.league, required this.playerIds});
}