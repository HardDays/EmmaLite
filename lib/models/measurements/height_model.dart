import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:hive/hive.dart';

part 'height_model.g.dart';

@HiveType(typeId: 3)
class HeightModel extends HiveObject implements Measurement {

  HeightModel({this.id, this.date, this.height}) {
    dateTime = DateTime.parse(date);
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final double height;

  @override
  String title = 'Вес';

  @override
  String longTitle = 'Вес';

  @override
  String units = 'кг';

  @override
  String value() => height.toString();

  @override
  String getFormattedDate() => 'дата';

  @override
  MeasurementEnum type = MeasurementEnum.heightModel;

  @override
  DateTime dateTime;

  @override
  void parse() {
    dateTime = DateTime.parse(date);
  }
}
