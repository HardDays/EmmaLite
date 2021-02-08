import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';

//SOLID где-то плачет в сторонке, но жизнь такова и больше никакова
class MeasurementLocalRepository {
  final _hiveBoxes = HiveBoxes();
  final _appLocalRepository = AppLocalRepository();

  bool  hasPressure(int id) {
    return _hiveBoxes.arterialPressureBox.values.any((e) => e.id == id);
  }

  bool  hasBloodSugar(int id) {
    return _hiveBoxes.bloodSugarBox.values.any((e) => e.id == id);
  }

  bool  hasHeightModel(int id) {
    return _hiveBoxes.heightModelBox.values.any((e) => e.id == id);
  }

  bool  hasPulse(int id) {
    return _hiveBoxes.pulseBox.values.any((e) => e.id == id);
  }
  
  bool hasTemperature(int id) {
    return _hiveBoxes.temperatureBox.values.any((e) => e.id == id);
  }

  List<ArterialPressure> getArterialPressure() {
    final userId = _appLocalRepository.currentUserId;
    return _hiveBoxes.arterialPressureBox.values
        .map((e) => e as ArterialPressure)
        .where((e) => e.userId == userId)
        .toList();
  }

  List<BloodSugar> getBloodSugar() {
    final userId = _appLocalRepository.currentUserId;
    return _hiveBoxes.bloodSugarBox.values
        .map((e) => e as BloodSugar)
        .where((e) => e.userId == userId)
        .toList();
  }

  List<HeightModel> getHeightModel() {
    final userId = _appLocalRepository.currentUserId;
    return _hiveBoxes.heightModelBox.values
        .map((e) => e as HeightModel)
        .where((e) => e.userId == userId)
        .toList();
  }

  List<Pulse> getPulse() {
    final userId = _appLocalRepository.currentUserId;
    return _hiveBoxes.pulseBox.values
        .map((e) => e as Pulse)
        .where((e) => e.userId == userId)
        .toList();
  }

  List<Temperature> getTemperature() {
    final userId = _appLocalRepository.currentUserId;
    return _hiveBoxes.temperatureBox.values
        .map((e) => e as Temperature)
        .where((e) => e.userId == userId)
        .toList();
  }

  void saveArterialPressure({ArterialPressure pressure}) {
    _hiveBoxes.arterialPressureBox.add(pressure);
  }

  void savePulse({Pulse pulse}) {
    _hiveBoxes.pulseBox.add(pulse);
  }

  void saveBloodSugar({BloodSugar bloodSugar}) {
    _hiveBoxes.bloodSugarBox.add(bloodSugar);
  }

  void saveHeightModel({HeightModel height}) {
    _hiveBoxes.heightModelBox.add(height);
  }

  void saveTemperature({Temperature temperature}) {
    _hiveBoxes.temperatureBox.add(temperature);
  }

  void deleteByIndex({Measurement meas, int index}) {
    final date = DateTime.now().toString();
    if (meas.runtimeType == ArterialPressure(date: date).runtimeType) {
      final i = _hiveBoxes.arterialPressureBox.values
          .map((e) => e as ArterialPressure)
          .toList()
          .lastIndexWhere((e) => e.id == meas.getUserId());
      _hiveBoxes.arterialPressureBox.deleteAt(i);
    } else if (meas.runtimeType == BloodSugar(date: date).runtimeType) {
      final i = _hiveBoxes.bloodSugarBox.values
          .map((e) => e as BloodSugar)
          .toList()
          .lastIndexWhere((e) => e.id == meas.getUserId());
      _hiveBoxes.bloodSugarBox.deleteAt(i);
    } else if (meas.runtimeType == Pulse(date: date).runtimeType) {
      final i = _hiveBoxes.pulseBox.values
          .map((e) => e as Pulse)
          .toList()
          .lastIndexWhere((e) => e.id == meas.getUserId());
      _hiveBoxes.pulseBox.deleteAt(i);
    } else if (meas.runtimeType == HeightModel(date: date).runtimeType) {
      final i = _hiveBoxes.heightModelBox.values
          .map((e) => e as HeightModel)
          .toList()
          .lastIndexWhere((e) => e.id == meas.getUserId());
      _hiveBoxes.heightModelBox.deleteAt(i);
    } else if (meas.runtimeType == Temperature(date: date).runtimeType) {
      final i = _hiveBoxes.temperatureBox.values
          .map((e) => e as Temperature)
          .toList()
          .lastIndexWhere((e) => e.id == meas.getUserId());
      _hiveBoxes.temperatureBox.deleteAt(i);
    }
  }
}
