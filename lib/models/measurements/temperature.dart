import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:hive/hive.dart';

part 'temperature.g.dart';

@HiveType(typeId: 5)
class Temperature extends HiveObject implements Measurement {
  @HiveField(0)
  int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  double temperature;

  @override
  String title = 'Температура';

  @override
  String units = '°C';

  @override
  String value() => temperature.toString();

  @override
  String getDate() => 'дата';
}
