import 'package:emma_mobile/models/assignment/assign_frequency.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:intl/intl.dart';

class RunTask {
  final bool enable;
  final DateTime dateTime;
  final DateTime completedDate;
  final int count;
  final AssignType type;
  final String assignName;
  final int assignId;

  const RunTask({
    this.enable = true,
    this.dateTime,
    this.count,
    this.type,
    this.assignName = '',
    this.assignId,
    this.completedDate,
  });

  bool get completed => completedDate != null;

  factory RunTask.fromJson(Map json) {
    return RunTask(
      count: json['count'],
      dateTime: DateTime.parse(json['dateTime']),
      enable: json['enable'],
      type: assignTypes[json['typeId'] ?? 0],
      assignName: json['assignName'],
      assignId: json['assignId'],
      completedDate: json['completedDate'] == null
          ? null
          : DateTime.parse(json['completedDate']),
    );
  }

  RunTask copyWith({bool enable, DateTime completedDate}) {
    return RunTask(
      assignId: assignId,
      assignName: assignName,
      enable: enable ?? this.enable,
      dateTime: dateTime,
      count: count,
      type: type,
      completedDate: completedDate ?? this.completedDate,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['enable'] = enable;
    data['dateTime'] = dateTime.toString();
    data['count'] = count;
    data['completedDate'] = completedDate?.toString();
    data['typeId'] = type.index;
    data['assignName'] = assignName;
    data['assignId'] = assignId;
    return data;
  }

  String mainText({bool isExpired, DateTime completeDate}) {
    if (completedDate != null) {
      return DateFormat.Hm().format(completeDate);
    }

    final now = DateTime.now();
    final dif = now.difference(dateTime).abs();
    final days = dif.inDays;
    final hour = dif.inHours >= 24 ? dif.inHours - (days * 24) : dif.inHours;
    final minutes = dif.inMinutes - (hour * 60 + (days * 24 * 60));

    final daysText = days == 0 ? '' : ' ${days.abs()} ${days.getPluralDays}';

    final hourText = hour == 0 ? '' : '${hour.abs()} ${hour.getPluralHour}';
    final minutesText = minutes == 0 && (hour != 0 || days != 0)
        ? ''
        : '${minutes.abs()} ${minutes.getPluralMinutes}';
    if (isExpired) {
      return '$daysText$hourText $minutesText ${'differenceBackTextLabel'.tr}';
    }
    return '${'differenceThroughTextLabel'.tr}$daysText $hourText $minutesText';
  }
}

class SingleTask {
  final int dayNumber;
  final List<TaskTime> taskTimes;

  const SingleTask({this.dayNumber, this.taskTimes});

  SingleTask copyWith({int dayNumber, List<TaskTime> tasks}) {
    return SingleTask(
      taskTimes: tasks ?? taskTimes,
      dayNumber: dayNumber ?? this.dayNumber,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dayNumber'] = dayNumber;
    data['taskTimes'] = taskTimes.map((e) => e.toJson()).toList();
    return data;
  }

  factory SingleTask.fromJson(Map json) {
    final List times = json['taskTimes'];
    return SingleTask(
      dayNumber: json['dayNumber'],
      taskTimes: times.map((e) => TaskTime.fromJson(e)).toList(),
    );
  }
}

class PeriodicTask {
  final AssignFrequencyInWeek type;
  final List<TaskTime> taskTimes;

  const PeriodicTask({this.type, this.taskTimes});

  PeriodicTask copyWith({
    AssignFrequencyInWeek type,
    List<TaskTime> tasks,
  }) {
    return PeriodicTask(
      type: type ?? this.type,
      taskTimes: tasks ?? taskTimes,
    );
  }

  factory PeriodicTask.fromJson(Map json) {
    final List times = json['taskTimes'];
    return PeriodicTask(
      taskTimes: times.map((e) => TaskTime.fromJson(e)).toList(),
      type: assignFrequencyInWeek[json['type']],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type.index;
    data['taskTimes'] = taskTimes.map((e) => e.toJson()).toList();
    return data;
  }
}

class TaskTime {
  final Time time;
  final int count;

  const TaskTime({this.time, this.count = 1});

  TaskTime copyWith({Time time, int count}) {
    return TaskTime(
      count: count ?? this.count,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['time'] = time.toJson();
    data['count'] = count;
    return data;
  }

  factory TaskTime.fromJson(Map json) {
    return TaskTime(
      time: Time.fromJson(json['time']),
      count: json['count'],
    );
  }

  factory TaskTime.defaultForCount({int maxCount, int currentNumber}) {
    if (maxCount == 1) {
      return TaskTime(time: Time(hour: 14, minutes: 0));
    }
    if (maxCount == 2) {
      if (currentNumber == 0) {
        return TaskTime(time: Time(hour: 12, minutes: 0));
      }
      if (currentNumber == 1) {
        return TaskTime(time: Time(hour: 18, minutes: 0));
      }
    }
    if (maxCount == 3) {
      if (currentNumber == 0) {
        return TaskTime(time: Time(hour: 10, minutes: 0));
      }
      if (currentNumber == 1) {
        return TaskTime(time: Time(hour: 14, minutes: 0));
      }
      if (currentNumber == 2) {
        return TaskTime(time: Time(hour: 20, minutes: 0));
      }
    }
    if (maxCount == 4) {
      if (currentNumber == 0) {
        return TaskTime(time: Time(hour: 8, minutes: 0));
      }
      if (currentNumber == 1) {
        return TaskTime(time: Time(hour: 13, minutes: 0));
      }
      if (currentNumber == 2) {
        return TaskTime(time: Time(hour: 17, minutes: 0));
      }
      if (currentNumber == 3) {
        return TaskTime(time: Time(hour: 21, minutes: 0));
      }
    }
    if (maxCount == 5) {
      if (currentNumber == 0) {
        return TaskTime(time: Time(hour: 8, minutes: 0));
      }
      if (currentNumber == 1) {
        return TaskTime(time: Time(hour: 11, minutes: 0));
      }
      if (currentNumber == 2) {
        return TaskTime(time: Time(hour: 15, minutes: 0));
      }
      if (currentNumber == 3) {
        return TaskTime(time: Time(hour: 19, minutes: 0));
      }
      if (currentNumber == 4) {
        return TaskTime(time: Time(hour: 22, minutes: 0));
      }
    }
    if (maxCount == 6) {
      if (currentNumber == 0) {
        return TaskTime(time: Time(hour: 6, minutes: 0));
      }
      if (currentNumber == 1) {
        return TaskTime(time: Time(hour: 9, minutes: 0));
      }
      if (currentNumber == 2) {
        return TaskTime(time: Time(hour: 12, minutes: 0));
      }
      if (currentNumber == 3) {
        return TaskTime(time: Time(hour: 15, minutes: 0));
      }
      if (currentNumber == 4) {
        return TaskTime(time: Time(hour: 18, minutes: 0));
      }
      if (currentNumber == 5) {
        return TaskTime(time: Time(hour: 21, minutes: 0));
      }
    }
    return null;
  }

  @override
  String toString() {
    return 'count $count time ${time.toString()}';
  }
}

class Time {
  final int hour;
  final int minutes;

  const Time({this.hour, this.minutes});

  @override
  String toString() {
    return '$hour $minutes';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hour'] = hour;
    data['minutes'] = minutes;
    return data;
  }

  factory Time.fromJson(Map json) {
    return Time(
      minutes: json['minutes'],
      hour: json['hour'],
    );
  }
}
