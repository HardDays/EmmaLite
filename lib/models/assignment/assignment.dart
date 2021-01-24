import 'package:hive/hive.dart';

part 'assignment.g.dart';

@HiveType(typeId: 0)
class Assignment extends HiveObject {
  Assignment({
    this.id,
    this.typeId,
  });

  int id;

  int typeId;

  String name;

  int dosage;

  int unitId;

  int frequency;

  List<int> frequencyCounts;

  List<double> frequencyValues;

  String startTime;

  String endTime;
  
  int periodId;

  List<String> photos;

  bool isStop;
}
