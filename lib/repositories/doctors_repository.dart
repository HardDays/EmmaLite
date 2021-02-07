import 'package:emma_mobile/models/doctor/doctor.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';

class DoctorsRepository {
  final _hiveBoxes = HiveBoxes();

  final _appLocalRepository = AppLocalRepository();

  List<Doctor> getDoctors() {
    final userId = _appLocalRepository.currentUserId;
    return _hiveBoxes.doctorsBox.values
        .map((e) => e as Doctor)
        .where((e) => e.userId == userId)
        .toList();
  }

  int _getIndex({int id}) => _hiveBoxes.doctorsBox.values
      .map((e) => e as Doctor)
      .toList()
      .lastIndexWhere((e) => e.id == id);

  void removeDoctorById(int id) {
    final index = _getIndex(id: id);
    _hiveBoxes.doctorsBox.deleteAt(index);
  }

  void updateDoctor({Doctor d}) {
    final index = _getIndex(id: d.id);
    _hiveBoxes.doctorsBox.putAt(index, d);
  }

  void saveDoctor(Doctor d) {
    _hiveBoxes.doctorsBox.add(d);
  }
}
