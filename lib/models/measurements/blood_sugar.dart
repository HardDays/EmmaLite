import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:hive/hive.dart';

part 'blood_sugar.g.dart';

@HiveType(typeId: 2)
class BloodSugar extends HiveObject implements Measurement {
  @HiveField(0)
  int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  double sugar;

  @override
  String title = 'Сахар в крови';

  @override
  String units = 'ммоль/л.';

  @override
  String value() => sugar.toString();

  @override
  String getDate() => 'дата';
}
