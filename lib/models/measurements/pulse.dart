import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:hive/hive.dart';

part 'pulse.g.dart';

@HiveType(typeId: 4)
class Pulse extends HiveObject implements Measurement {
  Pulse({this.id, this.date, this.pulse}) {
    dateTime = DateTime.parse(date);
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final int pulse;

  @override
  String title = 'Пульс';

  @override
  String longTitle = 'Пульс';

  @override
  String units = 'уд./мин.';

  @override
  String value() => pulse.toString();

  @override
  String getFormattedDate({bool showTimeIfToday = false}) =>
      dateTime.measurementDateFormatter(
        showTimeIfToday: showTimeIfToday,
      );

  @override
  MeasurementEnum type = MeasurementEnum.pulse;

  @override
  DateTime dateTime;

  @override
  void parse() {
    dateTime = DateTime.parse(date);
  }
}
