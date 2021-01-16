import 'package:hive/hive.dart';
part 'measurement_type.g.dart';

@HiveType(typeId: 0)
class MeasurementType extends HiveObject {
  MeasurementType(this.id, this.name, this.unitsName);
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String unitsName;

  @override
  String toString() => name;
}