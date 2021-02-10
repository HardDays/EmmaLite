import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:hive/hive.dart';

part 'height_model.g.dart';

@HiveType(typeId: 3)
class HeightModel extends HiveObject implements Measurement {
  HeightModel({this.id, this.date, this.height, this.userId}) {
    dateTime = DateTime.parse(date);
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final double height;

  @HiveField(3)
  final int userId;

  @override
  String title = 'weightTitle';

  @override
  String longTitle = 'weightTitle';

  @override
  String units = 'weightUnit';

  @override
  String value() => height.toStringAsFixed(1);

  @override
  String getFormattedDate() => dateTime.measurementDateFormatter();

  @override
  MeasurementEnum type = MeasurementEnum.heightModel;

  @override
  DateTime dateTime;

  @override
  int getUserId() => userId;

  @override
  String addTitle = 'addingWeightTitle';
}
