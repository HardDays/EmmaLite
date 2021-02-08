import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:hive/hive.dart';

part 'pulse.g.dart';

@HiveType(typeId: 4)
class Pulse extends HiveObject implements Measurement {
  Pulse({this.id, this.date, this.pulse, this.pulseType, this.userId}) {
    dateTime = DateTime.parse(date);
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final int pulse;

  @HiveField(3)
  final int pulseType;

  @HiveField(4)
  final int userId;

  @override
  String title = 'Пульс';

  @override
  String longTitle = 'Пульс';

  @override
  String units = 'уд./мин.';

  @override
  String value() => pulse.toStringAsFixed(1);

  @override
  String getFormattedDate() => dateTime.measurementDateFormatter();

  @override
  MeasurementEnum type = MeasurementEnum.pulse;

  @override
  DateTime dateTime;

  @override
  String inNewScreen = 'пульса';

  @override
  String toString() {
    return '$pulse $dateTime';
  }

  @override
  int getUserId() => userId;
}
