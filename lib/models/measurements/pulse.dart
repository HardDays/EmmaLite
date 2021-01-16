import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:hive/hive.dart';
part 'pulse.g.dart';

@HiveType(typeId: 4)
class Pulse extends HiveObject implements Measurement {
  @HiveField(0)
  int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  int pulse;

  @override
  String title = 'Пульс';

  @override
  String units = 'уд./мин.';

  @override
  String value() => pulse.toString();

  @override
  String getDate() => 'дата';
}
