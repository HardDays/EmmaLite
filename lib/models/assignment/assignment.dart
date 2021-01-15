import 'package:emma_mobile/utils/date_utils.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Assignment {
  Assignment({
    this.id,
    this.type,
    this.count,
    this.dosage,
    this.endDate,
    this.frequency,
    this.isDone,
    this.periodicity,
    this.startDate,
    this.title,
    this.unit,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String type;

  @HiveField(2)
  String title;

  @HiveField(3)
  num dosage;

  @HiveField(4)
  String unit;

  @HiveField(5)
  String frequency;

  @HiveField(6)
  String count;

  @HiveField(7)
  DateTime startDate;

  @HiveField(8)
  DateTime endDate;

  @HiveField(9)
  String periodicity;

  @HiveField(10)
  bool isDone = false;

  String get startDateString => formatDateToString(startDate);

  String get endDateString => formatDateToString(endDate);
}
