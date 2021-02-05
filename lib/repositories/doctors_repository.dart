import 'package:emma_mobile/models/doctor/doctor.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';

class DoctorsRepository {
  final _hiveBoxes = HiveBoxes();

  List<Doctor> getDoctors() =>
      _hiveBoxes.doctorsBox.values.map((e) => e as Doctor).toList();

  void removeDoctorByIndex(int index) {
    _hiveBoxes.doctorsBox.deleteAt(index);
  }

  void updateDoctorByIndex({int index, Doctor d}) {
    _hiveBoxes.doctorsBox.putAt(index, d);
  }

  void saveDoctor(Doctor d) {
    _hiveBoxes.doctorsBox.add(d);
  }
}
