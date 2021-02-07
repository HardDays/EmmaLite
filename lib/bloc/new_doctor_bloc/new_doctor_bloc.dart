import 'package:emma_mobile/bloc/new_doctor_bloc/new_doctor_state.dart';
import 'package:emma_mobile/models/doctor/doctor.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewDoctorBloc extends Cubit<NewDoctorState> {
  NewDoctorBloc({Doctor initialDoctor}) : super(NewDoctorState()) {
    _doctor = initialDoctor ??
        Doctor(
          userId: AppLocalRepository().currentUserId,
        );
    _initDoctor = initialDoctor;
    _canSave = _doctor.canSave;
  }

  Doctor _doctor;
  Doctor _initDoctor;

  Doctor get doctor => _doctor;

  bool _haveChanges = false;

  bool get haveChanges => _haveChanges;

  bool _canSave;

  bool get canSave => _canSave;

  void setName(String s) {
    _doctor = _doctor.copyWith(name: s);
    _update();
  }

  void setEmail(String s) {
    _doctor = _doctor.copyWith(email: s);
    _update();
  }

  void setComment(String s) {
    _doctor = _doctor.copyWith(comment: s);
    _update();
  }

  void _updateChanges() {
    if (!_haveChanges && _doctor.isEqual(_initDoctor)) {
      _haveChanges = true;
      emit(NewDoctorState());
    }
  }

  void _update() {
    _updateChanges();
    if (!_canSave) {
      if (_doctor.canSave) {
        _canSave = true;
        emit(NewDoctorState());
      }
    } else {
      if (!_doctor.canSave) {
        _canSave = false;
        emit(NewDoctorState());
      }
    }
  }
}
