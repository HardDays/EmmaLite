import 'package:hive/hive.dart';

part 'measurement.g.dart';

@HiveType(typeId: 0)
class Measurement extends HiveObject {
  Measurement(
    this.id,
    this.assetName,
    this.date,
    this.measureType,
    this.title,
    this.value,
  );

  @HiveField(0)
  int id;

  @HiveField(1)
  String assetName;

  @HiveField(2)
  String title;

  @HiveField(3)
  String date;

  @HiveField(4)
  String value;

  @HiveField(5)
  String measureType;
}
