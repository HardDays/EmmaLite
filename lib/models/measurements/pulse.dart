import 'package:hive/hive.dart';
part 'pulse.g.dart';

@HiveType(typeId: 4)
class Pulse extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String date;

  @HiveField(2)
  int pulse;
}
