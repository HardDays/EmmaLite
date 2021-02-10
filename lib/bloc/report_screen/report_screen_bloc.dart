import 'package:emma_mobile/bloc/report_screen/report_screen_state.dart';
import 'package:emma_mobile/models/report/report.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportScreenBloc extends Cubit<ReportScreenState> {
  ReportScreenBloc() : super(ReportScreenState()) {
    _report = Report();
  }

  Report _report;

  Report get report => _report;

  bool get canSave => _report.canSave;

  void setStartDate(DateTime date) {
    _report = _report.copyWith(startDate: date);
    _update();
  }

  void setEndDate(DateTime date) {
    _report = _report.copyWith(endDate: date);
    _update();
  }

  void setType(ReportTypeSend type) {
    _report = _report.copyWith(type: type);
    _update();
  }

  void setEmail(String email) {
    _report = _report.copyWith(email: email);
    _update();
  }

  void setComment(String comment) {
    _report = _report.copyWith(comment: comment);
    _update();
  }

  void _update() {
    emit(ReportScreenState());
  }
}
