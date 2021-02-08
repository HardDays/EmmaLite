import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:hive/hive.dart';

part 'temperature.g.dart';

@HiveType(typeId: 5)
class Temperature extends HiveObject implements Measurement {
  Temperature({this.id, this.date, this.temperature, this.userId}) {
    dateTime = DateTime.parse(date);
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final double temperature;

  @HiveField(3)
  final int userId;

  @override
  String title = 'Температура';

  @override
  String longTitle = 'Температура';

  @override
  String units = '°C';

  @override
  String value() => temperature.toStringAsFixed(1);

  @override
  String getFormattedDate() => dateTime.measurementDateFormatter();

  @override
  MeasurementEnum type = MeasurementEnum.temperature;

  @override
  DateTime dateTime;

  @override
  String inNewScreen = 'температуры';

  @override
  int getUserId() => userId;
}
