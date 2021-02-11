import 'package:emma_mobile/models/assignment/assign_frequency.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';
import 'package:emma_mobile/models/assignment/assign_unit.dart';
import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:emma_mobile/repositories/profile_local_repository.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:equatable/equatable.dart';

class Assignment extends Equatable {
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

  DateTime stoppedTime;

  List<RunTask> runTasks;

  bool isStopped;

  int userId;

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
    this.stoppedTime,
    this.isStopped,
    this.userId,
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
      isStopped = false;
      userId = AppLocalRepository().currentUserId;
    }
  }

  Assignment copyFowNew() {
    return Assignment(
      isStopped: false,
      type: type,
      doctorName: doctorName,
      unitId: unitId,
      startTime: startTime,
      singleTasks: []..addAll(singleTasks),
      periodicTask: periodicTask,
      otherTaskDateTime: otherTaskDateTime,
      isRegular: isRegular,
      endTime: endTime,
      dosage: dosage,
      photos: photos,
      name: name,
      frequency: frequency,
      id: DateTime.now().millisecondsSinceEpoch,
      userId: userId,
      runTasks: [],
    );
  }

  String countForPDFForTask(RunTask task) {
    if (type is AnalyzeAssignType || type is OtherAssignType) {
      return '';
    } else if (type is MedicineAssignType) {
      return ', ${task.count}x$dosage ${assignUnits[unitId]}';
    }
    return ', ${task.count}';
  }

  void stop() {
    isStopped = true;
    final now = DateTime.now();
    stoppedTime = DateTime.now();
    for (var i = 0; i < runTasks.length; i++) {
      if (runTasks[i].dateTime.isAfter(now)) {
        runTasks[i] = runTasks[i].copyWith(enable: false);
        Static.removeNotification(task: runTasks[i]);
      }
    }
  }

  void createNotifications() {
    final assignUser = ProfileLocalRepository().getUserById(id: userId);
    for (var i in runTasks) {
      if (i.enable && !i.completed)
        Static.addNotification(
          task: i,
          title: name,
          subtitle: assignUser.notificationSubtitle,
        );
    }
  }

  void clearNotifications() {
    for (var i in runTasks) {
      if (!i.completed || i.enable) {
        Static.removeNotification(task: i);
      }
    }
  }

  void restore() {
    isStopped = false;
    final now = DateTime.now();
    final dif = stoppedTime.difference(now).inDays;
    for (var i = 0; i < runTasks.length; i++) {
      if (runTasks[i].dateTime.isAfter(stoppedTime) &&
          runTasks[i].dateTime.isAfter(now)) {
        runTasks[i] = runTasks[i].copyWith(enable: true);
        runTasks[i].dateTime.add(Duration(days: dif));
      }
    }
    stoppedTime = null;
    runTasks.removeWhere((e) => !e.enable);
    createNotifications();
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
          id: (DateTime.now().millisecondsSinceEpoch / 1000).round(),
          enable: true,
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

    createNotifications();
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
        id: (DateTime.now().millisecondsSinceEpoch / 1000).round(),
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
    data['stoppedTime'] = stoppedTime;
    data['runTasks'] = runTasks.map((e) => e.toJson()).toList();
    data['isStopped'] = isStopped;
    data['userId'] = userId;
    return data;
  }

  factory Assignment.fromJson(Map<dynamic, dynamic> json) {
    final List photos = json['photos'];
    final List singleTasks = json['singleTasks'];
    final List runTasks = json['runTasks'];
    final stoppedTime = json['stoppedTime'];
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
      stoppedTime: stoppedTime == null ? null : DateTime.parse(stoppedTime),
      isStopped: json['isStopped'] ?? false,
      userId: json['userId'],
    );
  }

  @override
  List<Object> get props => [id];
}
