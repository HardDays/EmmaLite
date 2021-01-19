import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:hive/hive.dart';

import 'measurement.dart';

part 'arterial_pressure.g.dart';

@HiveType(typeId: 1)
class ArterialPressure extends HiveObject implements Measurement {
  ArterialPressure({this.id, this.date, this.top, this.under}) {
    dateTime = DateTime.parse(date);
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final int top;

  @HiveField(3)
  final int under;

  @override
  String title = 'Давление';

  @override
  String longTitle = 'Артериальное давление';

  @override
  String units = 'мм.рт.ст.';

  @override
  String value() => '$top/$under';

  @override
  String getFormattedDate({bool showTimeIfToday = false}) =>
      dateTime.measurementDateFormatter(
        showTimeIfToday: showTimeIfToday,
      );

  @override
  MeasurementEnum type = MeasurementEnum.arterialPressure;

  @override
  DateTime dateTime;
}
