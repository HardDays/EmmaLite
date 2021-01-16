import 'package:hive/hive.dart';

part 'blood_sugar.g.dart';

@HiveType(typeId: 2)
class BloodSugar extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  double value;
}
