import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:hive/hive.dart';

import 'measurement.dart';

part 'arterial_pressure.g.dart';

@HiveType(typeId: 1)
class ArterialPressure extends HiveObject implements Measurement {
  ArterialPressure({this.id, this.date, this.top, this.under, this.userId}) {
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

  @HiveField(4)
  final int userId;

  @override
  String title = 'bloodPressure';

  @override
  String longTitle = 'bloodPressure';

  @override
  String units = 'bloodPressureUnit';

  @override
  String value() => '$under/$top';

  @override
  String getFormattedDate() => dateTime.measurementDateFormatter();

  @override
  MeasurementEnum type = MeasurementEnum.arterialPressure;

  @override
  DateTime dateTime;

  @override
  int getUserId() => userId;

  @override
  String addTitle = 'titleAddingPressureViewco'.tr;
}
