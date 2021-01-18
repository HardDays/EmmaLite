import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:hive/hive.dart';

part 'temperature.g.dart';

@HiveType(typeId: 5)
class Temperature extends HiveObject implements Measurement {

  Temperature({this.id, this.date, this.temperature}) {
    dateTime = DateTime.parse(date);
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final double temperature;

  @override
  String title = 'Температура';

  @override
  String longTitle = 'Температура';

  @override
  String units = '°C';

  @override
  String value() => temperature.toString();

  @override
  String getFormattedDate() => 'дата';

  @override
  MeasurementEnum type = MeasurementEnum.temperature;

  @override
  DateTime dateTime;

  @override
  void parse() {
    dateTime = DateTime.parse(date);
  }
}
