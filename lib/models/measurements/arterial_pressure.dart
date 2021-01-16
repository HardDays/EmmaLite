import 'package:hive/hive.dart';

import 'measurement.dart';

part 'arterial_pressure.g.dart';

@HiveType(typeId: 1)
class ArterialPressure extends HiveObject implements Measurement {
  @HiveField(0)
  int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  int top;

  @HiveField(3)
  int under;

  @override
  String title = 'Давление';

  @override
  String units = 'мм.рт.ст.';

  @override
  String value() => '$top/$under';

  @override
  String getDate() => 'дата';

}
