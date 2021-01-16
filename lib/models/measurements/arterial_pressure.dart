import 'package:hive/hive.dart';

part 'arterial_pressure.g.dart';

@HiveType(typeId: 1)
class ArterialPressure extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  int top;

  @HiveField(3)
  int under;
}
