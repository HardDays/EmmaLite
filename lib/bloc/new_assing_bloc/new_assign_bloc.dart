import 'package:emma_mobile/bloc/new_assing_bloc/new_assign_state.dart';
import 'package:emma_mobile/models/assignment/assign_frequency.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';
import 'package:emma_mobile/models/assignment/assignment.dart';
import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewAssignBloc extends Cubit<NewAssignState> {
  NewAssignBloc({Assignment assignment}) : super(NewAssignState()) {
    _assignment = assignment ?? Assignment();

    _isCreate = assignment = null;
  }

  Assignment _assignment;

  Assignment get assignment => _assignment;

  bool _isCreate;

  bool get isCreate => _isCreate;

  Future<void> pickImage() async {
    final res = await ImagePicker().getImage(source: ImageSource.gallery);

    if (res != null) {
      _assignment.photos.add(res.path);
    }
    emit(NewAssignState());
  }

  bool _canSave = false;

  void deletePhoto({int index}) {
    _assignment.photos.removeAt(index);
    _update();
  }

  void setType(int typeId) {
    _assignment.type = assignTypes[typeId];
    _update();
  }

  void setName(String s) {
    _assignment.name = s;
    _updateSetText();
  }

  void setDosage(String dosage) {
    if (dosage == null || dosage?.isEmpty == true) {
      _assignment.dosage = null;
      return;
    }
    final value = int.parse(dosage);
    _assignment.dosage = value;
    _update();
  }

  void setUnit(int unit) {
    _assignment.unitId = unit;
    _update();
  }

  void setStartTime(DateTime time) {
    _assignment.startTime = time;
    _update();
  }

  void setEndTime(DateTime time) {
    _assignment.endTime = time;
    _update();
  }

  void setFrequency(int frequency) {
    _assignment.frequency = frequency;
    final List<TaskTime> tasks = [];
    for (int i = 0; i < _assignment.frequency + 1; i++) {
      tasks.add(
        TaskTime.defaultForCount(
          currentNumber: i,
          maxCount: _assignment.frequency + 1,
        ),
      );
    }
    _assignment.periodicTask = _assignment.periodicTask.copyWith(
      type: _assignment.periodicTask.type,
      tasks: tasks,
    );
    for (var i = 0; i < _assignment.singleTasks.length; i++) {
      _assignment.singleTasks[i] = _assignment.singleTasks[i].copyWith(
        tasks: tasks,
      );
    }
    _update();
  }

  void setIsRegular({bool regular = true}) {
    _assignment.isRegular = regular;
    _update();
  }

  void setRegularTypeCount(AssignFrequencyInWeek type) {
    _assignment.periodicTask = _assignment.periodicTask.copyWith(type: type);
    _update();
  }

  void setWeekday({int dayNumber, int taskNumber}) {
    _assignment.singleTasks[taskNumber] =
        _assignment.singleTasks[taskNumber].copyWith(
      dayNumber: dayNumber,
    );
    _update();
  }

  void addSingleTask() {
    _assignment.singleTasks.add(_assignment.singleTasks.last);
    _update();
  }

  void removeSingleTask() {
    _assignment.singleTasks.removeLast();
    _update();
  }

  void setSingleTime({TaskTime taskTime, int taskIndex, int index}) {
    _assignment.singleTasks[taskIndex].taskTimes[index] = taskTime;
    _update();
  }

  void setPeriodicTime({TaskTime taskTime, int index}) {
    _assignment.periodicTask.taskTimes[index] = taskTime;
    _update();
  }

  void setOthersTime(TaskTime time) {
    final prev = _assignment.otherTaskDateTime;
    _assignment.otherTaskDateTime = DateTime(
      prev.year,
      prev.month,
      prev.day,
      time.time.hour,
      time.time.minutes,
    );
    _update();
  }

  void setDoctor(String s) {
    _assignment.doctorName = s;
    _updateSetText();
  }

  void _updateSetText() {
    if (_canSave != enableSave) {
      _canSave = !_canSave;
      _update();
    }
  }

  bool get enableSave {
    if (_assignment.name == null || _assignment.name.isEmpty) {
      return false;
    }
    if (_assignment.type is AnalyzeAssignType) {
      if (_assignment.doctorName == null || _assignment.doctorName.isEmpty) {
        return false;
      }
    }
    if (_assignment.type is LifestyleAssignType ||
        _assignment.type is MeasureAssignType ||
        _assignment.type is MedicineAssignType) {
      if (_assignment.doctorName == null || _assignment.doctorName.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void _update() {
    emit(NewAssignState());
  }
}
