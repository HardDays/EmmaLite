import 'package:emma_mobile/models/assignment/assign_frequency.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';

class Assignment {
  int id;

  AssignEnum typeId;

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

  String doctorName = '';

  Assignment({
    this.id,
    this.typeId,
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
  }) {
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
    typeId = AssignEnum.medicines;
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
      type: AssignFrequencyInWeekEnum.everyday,
    );
  }
}

class SingleTask {
  final int dayNumber;
  final List<TaskTime> taskTimes;

  const SingleTask({this.dayNumber, this.taskTimes});

  SingleTask copyWith({int dayNumber, List<TaskTime> tasks}) {
    return SingleTask(
      taskTimes: tasks ?? this.taskTimes,
      dayNumber: dayNumber ?? this.dayNumber,
    );
  }
}

class PeriodicTask {
  final AssignFrequencyInWeekEnum type;
  final List<TaskTime> taskTimes;

  const PeriodicTask({this.type, this.taskTimes});

  PeriodicTask copyWith({
    AssignFrequencyInWeekEnum type,
    List<TaskTime> tasks,
  }) {
    return PeriodicTask(
      type: type ?? this.type,
      taskTimes: tasks ?? this.taskTimes,
    );
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
}

class PickerTimeRange {
  final int minHour;
  final int maxHour;

  const PickerTimeRange({this.minHour, this.maxHour});

  factory PickerTimeRange.calculate({
    int maxCount,
    int currentNumber,
  }) {
    if (maxCount == 1) {
      return PickerTimeRange(minHour: 0, maxHour: 23);
    }
    if (maxCount == 2) {
      if (currentNumber == 0) {
        return PickerTimeRange(minHour: 0, maxHour: 13);
      }
      if (currentNumber == 1) {
        return PickerTimeRange(minHour: 14, maxHour: 23);
      }
    }
    if (maxCount == 3) {
      if (currentNumber == 0) {
        return PickerTimeRange(minHour: 0, maxHour: 11);
      }
      if (currentNumber == 1) {
        return PickerTimeRange(minHour: 12, maxHour: 16);
      }
      if (currentNumber == 2) {
        return PickerTimeRange(minHour: 17, maxHour: 23);
      }
    }
    if (maxCount == 4) {
      if (currentNumber == 0) {
        return PickerTimeRange(minHour: 0, maxHour: 9);
      }
      if (currentNumber == 1) {
        return PickerTimeRange(minHour: 10, maxHour: 14);
      }
      if (currentNumber == 2) {
        return PickerTimeRange(minHour: 15, maxHour: 18);
      }
      if (currentNumber == 3) {
        return PickerTimeRange(minHour: 19, maxHour: 23);
      }
    }
    if (maxCount == 5) {
      if (currentNumber == 0) {
        return PickerTimeRange(minHour: 0, maxHour: 9);
      }
      if (currentNumber == 1) {
        return PickerTimeRange(minHour: 10, maxHour: 12);
      }
      if (currentNumber == 2) {
        return PickerTimeRange(minHour: 13, maxHour: 16);
      }
      if (currentNumber == 3) {
        return PickerTimeRange(minHour: 17, maxHour: 20);
      }
      if (currentNumber == 4) {
        return PickerTimeRange(minHour: 21, maxHour: 23);
      }
    }
    if (maxCount == 6) {
      if (currentNumber == 0) {
        return PickerTimeRange(minHour: 0, maxHour: 7);
      }
      if (currentNumber == 1) {
        return PickerTimeRange(minHour: 8, maxHour: 10);
      }
      if (currentNumber == 2) {
        return PickerTimeRange(minHour: 11, maxHour: 13);
      }
      if (currentNumber == 3) {
        return PickerTimeRange(minHour: 14, maxHour: 16);
      }
      if (currentNumber == 4) {
        return PickerTimeRange(minHour: 17, maxHour: 19);
      }
      if (currentNumber == 5) {
        return PickerTimeRange(minHour: 20, maxHour: 23);
      }
    }
    return null;
  }
}
