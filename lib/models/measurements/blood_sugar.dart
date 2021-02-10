import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:hive/hive.dart';

part 'blood_sugar.g.dart';

@HiveType(typeId: 2)
class BloodSugar extends HiveObject implements Measurement {
  BloodSugar({this.id, this.date, this.sugar, this.eatTime, this.userId}) {
    dateTime = DateTime.parse(date);
    if (eatTime != null) {
      eatDateTime = DateTime.parse(eatTime);
    }
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final double sugar;

  @HiveField(3)
  final String eatTime;

  @HiveField(4)
  final int userId;

  @override
  String title = 'bloodSugar';

  @override
  String longTitle = 'bloodSugar';

  @override
  String units = 'bloodSugarUnit';

  @override
  String value() => sugar.toStringAsFixed(1);

  DateTime eatDateTime;

  @override
  String getFormattedDate() => dateTime.measurementDateFormatter();

  @override
  MeasurementEnum type = MeasurementEnum.bloodSugar;

  @override
  DateTime dateTime;

  @override
  int getUserId() => userId;

  @override
  String addTitle = 'addingBloodSugarTitle';
}
