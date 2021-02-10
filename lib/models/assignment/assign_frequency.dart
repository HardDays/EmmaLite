import 'package:get/get.dart';

List<String> assignFrequency = [
  'prescriptionValueTypeFrequency_1'.tr,
  'prescriptionValueTypeFrequency_2'.tr,
  'prescriptionValueTypeFrequency_3'.tr,
  'prescriptionValueTypeFrequency_4'.tr,
  'prescriptionValueTypeFrequency_5'.tr,
  'prescriptionValueTypeFrequency_6'.tr,
];

List<String> assignFrequencyWeekday = [
  'Понедельник',
  'Вторник',
  'Среда',
  'Четверг',
  'Пятница',
  'Суббота',
  'Воскресенье',
];

List<AssignFrequencyInWeek> assignFrequencyInWeek = [
  EverydayAssignFrequencyInWeek(),
  Every2daysAssignFrequencyInWeek(),
  OneInWeekAssignFrequencyInWeek(),
];

abstract class AssignFrequencyInWeek {
  final int addedDay;
  final String title;
  final int index;

  AssignFrequencyInWeek({this.addedDay, this.title, this.index});
}

class EverydayAssignFrequencyInWeek implements AssignFrequencyInWeek {
  @override
  int get addedDay => 1;

  @override
  int get index => 0;

  @override
  String get title => 'prescriptionValueTypePeriodicity_1'.tr;
}

class Every2daysAssignFrequencyInWeek implements AssignFrequencyInWeek {
  @override
  int get addedDay => 2;

  @override
  int get index => 1;

  @override
  String get title => 'prescriptionValueTypePeriodicity_2'.tr;
}

class OneInWeekAssignFrequencyInWeek implements AssignFrequencyInWeek {
  @override
  int get addedDay => 7;

  @override
  int get index => 2;

  @override
  String get title => 'prescriptionValueTypePeriodicity_3'.tr;
}
