import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:hive/hive.dart';

part 'height_model.g.dart';

@HiveType(typeId: 3)
class HeightModel extends HiveObject implements Measurement {
  @HiveField(0)
  int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  double height;

  @override
  String title = 'Вес';

  @override
  String units = 'кг';

  @override
  String value() => height.toString();

  @override
  String getDate() => 'дата';
}
