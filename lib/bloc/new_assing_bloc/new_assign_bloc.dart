import 'package:emma_mobile/bloc/new_assing_bloc/new_assign_state.dart';
import 'package:emma_mobile/models/assignment/assign_frequency.dart';
import 'package:emma_mobile/models/assignment/assignment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewAssignBloc extends Cubit<NewAssignState> {
  NewAssignBloc() : super(NewAssignState());

  Assignment _assignment = Assignment();

  Assignment get assignment => _assignment;

  Future<void> pickImage() async {
    final res = await ImagePicker().getImage(source: ImageSource.gallery);

    if (res != null) {
      _assignment.photos.add(res.path);
    }
    emit(NewAssignState());
  }

  void deletePhoto({int index}) {
    _assignment.photos.removeAt(index);
    _update();
  }

  void setType(int typeId) {
    _assignment.typeId = typeId;
    _update();
  }

  void setDosage(String dosage) {
    if (dosage == null || dosage?.isEmpty == true) {
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
    if (assignment.isRegular) {
      _assignment.periodicTask = _assignment.periodicTask.copyWith(
        type: _assignment.periodicTask.type,
        tasks: tasks,
      );
    } else {
      for (var i = 0; i < _assignment.singleTasks.length; i++) {
        _assignment.singleTasks[i] = _assignment.singleTasks[i].copyWith(
          tasks: tasks,
        );
      }
    }
    _update();
  }

  void setIsRegular({bool regular = true}) {
    _assignment.isRegular = regular;
    _update();
  }

  void setRegularTypeCount(AssignFrequencyInWeekEnum type) {
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

  void _update() {
    emit(NewAssignState());
  }
}
