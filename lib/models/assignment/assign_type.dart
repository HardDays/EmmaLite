
final List<AssignType> assignTypes = [
  MedicineAssignType(),
  LifestyleAssignType(),
  MeasureAssignType(),
  AnalyzeAssignType(),
  OtherAssignType(),
];


abstract class AssignType {
  final String title;
  final int index;
  final String iconPath;

  const AssignType({this.title, this.index, this.iconPath});
}

class MedicineAssignType implements AssignType {
  @override
  String get iconPath => 'assets/icons/medicine.svg';

  @override
  int get index => 0;

  @override
  String get title => 'Лекарства';
}

class LifestyleAssignType implements AssignType {
  @override
  String get iconPath => 'assets/icons/lifestyle.svg';

  @override
  int get index => 1;

  @override
  String get title => 'Образ жизни';
}

class MeasureAssignType implements AssignType {
  @override
  String get iconPath => 'assets/icons/measure_short.svg';

  @override
  int get index => 2;

  @override
  String get title => 'Измерение';
}

class AnalyzeAssignType implements AssignType {
  @override
  String get iconPath => 'assets/icons/analyze.svg';

  @override
  int get index => 3;

  @override
  String get title => 'Анализ';
}

class OtherAssignType implements AssignType {
  @override
  String get iconPath => 'assets/icons/other.svg';

  @override
  int get index => 4;

  @override
  String get title => 'Другое';
}