List<String> assignFrequency = [
  'Один раз в день',
  'Два раза в день',
  'Три раза в день',
  'Четыре раза в день',
  'Пять раз в день',
  'Шесть раз в день',
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
  String get title => 'Ежедневно';
}

class Every2daysAssignFrequencyInWeek implements AssignFrequencyInWeek {
  @override
  int get addedDay => 2;

  @override
  int get index => 1;

  @override
  String get title => 'Раз в два дня';
}

class OneInWeekAssignFrequencyInWeek implements AssignFrequencyInWeek {
  @override
  int get addedDay => 7;

  @override
  int get index => 2;

  @override
  String get title => 'Раз в неделю';
}
