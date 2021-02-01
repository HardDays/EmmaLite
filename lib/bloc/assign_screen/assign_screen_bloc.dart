import 'package:emma_mobile/bloc/assign_screen/assign_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignScreenBloc extends Cubit<AssignScreenState> {
  AssignScreenBloc() : super(DoingAssignScreenState()) {
    _init();
  }

  final List<DateTime> _doingDates = [];
  final List<DateTime> _completedDates = [];

  int _doingIndex;

  int _completedIndex;

  List<DateTime> get doingDates => _doingDates;

  List<DateTime> get completedDates => _completedDates;

  int get currentActiveIndex =>
      state is DoingAssignScreenState ? _doingIndex : _completedIndex;

  DateTime currentDate(int i) =>
      state is DoingAssignScreenState ? _doingDates[i] : _completedDates[i];

  DateTime get activeDate => state is DoingAssignScreenState
      ? _doingDates[_doingIndex]
      : _completedDates[_completedIndex];

  int get doingIndex => _doingIndex;

  int get completedIndex => _completedIndex;

  void _init() {
    for (var i = 0; i <= 365; i++) {
      _doingDates.add(DateTime.now().add(Duration(days: i)));
      _completedDates.add(DateTime.now().subtract(Duration(days: i)));
    }
    _completedIndex = 0;
    _doingIndex = 0;
  }

  void setIndex(int index) {
    if (state is DoingAssignScreenState) {
      _doingIndex = index;
      emit(DoingAssignScreenState());
    } else {
      _completedIndex = index;
      emit(CompletedAssignScreenState());
    }
  }

  void addDoingState() {
    emit(DoingAssignScreenState());
  }

  void addCompletedState() {
    emit(CompletedAssignScreenState());
  }

  void addHistoryState() {
    emit(HistoryAssignScreenState());
  }
}
