import 'package:hive/hive.dart';

part 'temperature.g.dart';

@HiveType(typeId: 5)
class Temperature extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  double value;
}
