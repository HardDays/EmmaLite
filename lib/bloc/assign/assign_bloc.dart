import 'package:emma_mobile/bloc/assign/assign_state.dart';
import 'package:emma_mobile/models/assignment/assignment.dart';
import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:emma_mobile/repositories/assignment_local_repository.dart';
import 'package:emma_mobile/ui/components/calendar.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignBloc extends Cubit<AssignState> {
  AssignBloc() : super(AssignState()) {
    _init();
  }

  final _assignmentLocalRepository = AssignmentLocalRepository();

  List<Assignment> _assignment;

  List<Assignment> get assignment => _assignment;

  List<RunTask> getTaskInDay({DateTime date}) {
    final List<RunTask> bufList = [];
    for (var i in _assignment) {
      if (!i.isStopped)
        bufList.addAll(i.runTasks.where((e) => e.dateTime.isInDay(date)));
    }
    final now = DateTime.now();
    bufList.sort(
      (i, j) =>
          j.dateTime.difference(now).compareTo(i.dateTime.difference(now)),
    );
    return bufList;
  }

  List<CalendarMarker> calendarMarkers() {
    final List<RunTask> bufList = [];
    for (var i in _assignment) {
      if (!i.isStopped) {
        bufList.addAll(i.runTasks);
      }
    }

    final dates = <DateTime>{};

    for (var i in bufList) {
      dates.add(DateTime(i.dateTime.year, i.dateTime.month, i.dateTime.day));
    }

    final List<CalendarMarker> markers = [];

    for (var i in dates) {
      final inDay = <RunTask>[];
      inDay.addAll(bufList.where((e) => e.dateTime.isInDay(i)));

      if (inDay.isEmpty) {
        continue;
      }

      if (inDay.every((e) => e.completed)) {
        markers.add(
          CalendarMarker(
            color: AppColors.c00ACE3,
            dateTime: i,
          ),
        );
      } else {
        markers.add(
          CalendarMarker(
            color: AppColors.cFF3B30,
            dateTime: i,
          ),
        );
      }
    }
    return markers;
  }

  void _init() {
    _assignment = _assignmentLocalRepository.getAssignment();
  }

  void reload() {
    _init();
    emit(AssignState());
  }

  Assignment getAssignById(int id) => _assignment.firstWhere((e) => e.id == id);

  void addAssignment(Assignment assign) {
    _assignment.add(assign);
    _assignmentLocalRepository.addAssignment(assign);
    emit(AssignState());
  }

  void updateAssignment(Assignment assign) {
    final index = _assignment.lastIndexWhere((e) => e.id == assign.id);
    _assignment[index] = assign;
    _assignmentLocalRepository.insert(assign: assign);
    emit(AssignState());
  }

  void deleteAssignment(Assignment assign) {
    final index = _assignment.lastIndexWhere((e) => e.id == assign.id);
    _assignment.removeAt(index);
    _assignmentLocalRepository.removeById(id: assign.id);
    emit(AssignState());
  }

  void completeTask(RunTask task) {
    final assignIndex =
        _assignment.lastIndexWhere((e) => e.runTasks.contains(task));
    final taskIndex =
        _assignment[assignIndex].runTasks.lastIndexWhere((e) => e == task);

    _assignment[assignIndex].runTasks[taskIndex] = _assignment[assignIndex]
        .runTasks[taskIndex]
        .copyWith(completedDate: DateTime.now());
    _assignmentLocalRepository.insert(assign: _assignment[assignIndex]);
    emit(AssignState());
  }
}
