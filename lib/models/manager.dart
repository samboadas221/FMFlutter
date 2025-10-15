import 'package:hive/hive.dart';

part 'manager.g.dart';  // Genera con 'flutter pub run build_runner build'

@HiveType(typeId: 0)
class Manager extends HiveObject {
  @HiveField(0) String name;
  @HiveField(1) String surname;
  @HiveField(2) String style;
  @HiveField(3) String avatar;
  Manager({required this.name, required this.surname, required this.style, required this.avatar});
}