import 'package:emma_mobile/models/assignment/assign_frequency.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';
import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:emma_mobile/utils/utils.dart';

class Assignment {
  int id;

  AssignType type;

  String name;

  int dosage;

  int unitId;

  int frequency;

  DateTime startTime;

  DateTime endTime;

  DateTime otherTaskDateTime;

  List<String> photos;

  bool isRegular;

  List<SingleTask> singleTasks;

  PeriodicTask periodicTask;

  String doctorName;

  List<DateTime> stoppedTimes;

  List<RunTask> runTasks;

  Assignment({
    this.id,
    this.type,
    this.name,
    this.dosage,
    this.unitId,
    this.frequency,
    this.startTime,
    this.endTime,
    this.photos,
    this.isRegular,
    this.singleTasks,
    this.periodicTask,
    this.otherTaskDateTime,
    this.runTasks,
    this.doctorName,
    this.stoppedTimes,
  }) {
    if (id == null) {
      id = DateTime.now().millisecondsSinceEpoch;
      photos = [];
      singleTasks = [
        SingleTask(
          taskTimes: [
            TaskTime(
              time: Time(hour: 12, minutes: 0),
              count: 1,
            ),
          ],
          dayNumber: 0,
        ),
      ];
      type = MedicineAssignType();
      unitId = 0;
      frequency = 0;
      startTime = DateTime.now();
      endTime = DateTime.now();
      otherTaskDateTime = DateTime.now();
      isRegular = true;
      stoppedTimes = [];
      periodicTask = PeriodicTask(
        taskTimes: [
          TaskTime(
            time: Time(hour: 12, minutes: 0),
            count: 1,
          ),
        ],
        type: EverydayAssignFrequencyInWeek(),
      );
      runTasks = [];
    }
  }

  void generateTasks() {
    runTasks = [];
    if (type is OtherAssignType || type is AnalyzeAssignType) {
      runTasks.add(
        RunTask(
          dateTime: otherTaskDateTime,
          type: type,
          assignName: name,
          assignId: id,
        ),
      );
    } else {
      if (isRegular) {
        _generateRegular();
      } else {
        _generateSingles();
      }
    }
    runTasks.sort((i, j) => i.dateTime.compareTo(j.dateTime));
  }

  void _generateRegular() {
    DateTime bufDateTime = startTime;
    while (bufDateTime.isBefore(endTime)) {
      _generateTasksForDay(
        startDate: bufDateTime,
        times: periodicTask.taskTimes,
      );

      bufDateTime = bufDateTime.add(
        Duration(days: periodicTask.type.addedDay),
      );
    }
  }

  void _generateSingles() {
    for (var i in singleTasks) {
      DateTime bufDate = startTime.copyWith();
      while (bufDate.isBefore(endTime)) {
        if (bufDate.weekday == (i.dayNumber + 1)) {
          _generateTasksForDay(times: i.taskTimes, startDate: bufDate);
        }
        bufDate = bufDate.add(const Duration(days: 1));
      }
    }
  }

  void _generateTasksForDay({List<TaskTime> times, DateTime startDate}) {
    for (int i = 0; i < times.length; i++) {
      final date = startDate.copyWith(
        hour: times[i].time.hour,
        minute: times[i].time.minutes,
      );
      if (date.isAfter(endTime)) {
        break;
      }
      final task = RunTask(
        dateTime: date,
        count: times[i].count,
        assignName: name,
        type: type,
        assignId: id,
      );
      runTasks.add(task);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id ?? DateTime.now().millisecondsSinceEpoch;
    data['typeId'] = type.index;
    data['name'] = name;
    data['dosage'] = dosage;
    data['unitId'] = unitId;
    data['frequency'] = frequency;
    data['startTime'] = startTime.toString();
    data['endTime'] = endTime.toString();
    data['otherTaskDateTime'] = otherTaskDateTime.toString();
    data['photos'] = photos;
    data['isRegular'] = isRegular;
    data['singleTasks'] = singleTasks.map((e) => e.toJson()).toList();
    data['periodicTask'] = periodicTask.toJson();
    data['doctorName'] = doctorName;
    data['stoppedTimes'] = stoppedTimes.map((e) => e.toString()).toList();
    data['runTasks'] = runTasks.map((e) => e.toJson()).toList();
    return data;
  }

  factory Assignment.fromJson(Map<dynamic, dynamic> json) {
    final List photos = json['photos'];
    final List singleTasks = json['singleTasks'];
    final List runTasks = json['runTasks'];
    final List stoppedTimes = json['stoppedTimes'];
    return Assignment(
      id: json['id'],
      type: assignTypes[json['typeId']],
      frequency: json['frequency'],
      name: json['name'],
      photos: photos.map((e) => e as String).toList(),
      dosage: json['dosage'],
      endTime: DateTime.parse(json['endTime']),
      isRegular: json['isRegular'],
      otherTaskDateTime: DateTime.parse(json['otherTaskDateTime']),
      periodicTask: PeriodicTask.fromJson(json['periodicTask']),
      singleTasks: singleTasks.map((e) => SingleTask.fromJson(e)).toList(),
      startTime: DateTime.parse(json['startTime']),
      unitId: json['unitId'],
      runTasks: runTasks.map((e) => RunTask.fromJson(e)).toList(),
      doctorName: json['doctorName'],
      stoppedTimes: stoppedTimes.map((e) => DateTime.parse(e)).toList(),
    );
  }
}
