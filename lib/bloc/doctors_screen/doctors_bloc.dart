import 'package:emma_mobile/bloc/doctors_screen/doctors_state.dart';
import 'package:emma_mobile/models/doctor/doctor.dart';
import 'package:emma_mobile/repositories/doctors_repository.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsBloc extends Cubit<DoctorsState> {
  DoctorsBloc() : super(DoctorsState()) {
    _init();
  }

  final _doctorsRepository = DoctorsRepository();

  List<Doctor> _doctors;

  List<Doctor> get doctors => _doctors;

  void _init() {
    _doctors = _doctorsRepository.getDoctors();
  }

  void reload() {
    _init();
    emit(DoctorsState());
  }

  void updateDoctor(Doctor d) {
    final index = _doctors.lastIndexWhere((e) => e.id == d.id);
    _doctors[index] = d;
    _doctorsRepository.updateDoctor(d: d);
    Toast.show('Данные сохранены');
    emit(DoctorsState());
  }

  void deleteDoctor(Doctor d) {
    final index = _doctors.lastIndexWhere((e) => e.id == d.id);
    _doctors.removeAt(index);
    _doctorsRepository.removeDoctorById(d.id);
    Toast.show('Контакт удален');
    emit(DoctorsState());
  }

  void saveDoctor(Doctor d) {
    _doctors.add(d);
    _doctorsRepository.saveDoctor(d);
    Toast.show('Контакт добавлен');
    emit(DoctorsState());
  }
}
