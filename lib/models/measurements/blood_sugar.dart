import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:hive/hive.dart';

part 'blood_sugar.g.dart';

@HiveType(typeId: 2)
class BloodSugar extends HiveObject implements Measurement {

  BloodSugar({this.id, this.date, this.sugar}) {
    dateTime = DateTime.parse(date);
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final double sugar;

  @override
  String title = 'Сахар в крови';

  @override
  String longTitle = 'Сахар в крови';

  @override
  String units = 'ммоль/л.';

  @override
  String value() => sugar.toString();

  @override
  String getFormattedDate() => 'дата';

  @override
  MeasurementEnum type = MeasurementEnum.bloodSugar;

  @override
  DateTime dateTime;
}
