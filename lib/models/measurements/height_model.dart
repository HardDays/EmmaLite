import 'package:hive/hive.dart';

part 'height_model.g.dart';

@HiveType(typeId: 3)
class HeightModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  double height;
}
