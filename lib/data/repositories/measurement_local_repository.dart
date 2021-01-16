import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';
import 'package:emma_mobile/utils/utils.dart';

class MeasurementLocalRepository {
  final _hiveBoxes = HiveBoxes();

  List<ArterialPressure> getArterialPressure() =>
      _hiveBoxes.arterialPressureBox.values.toList().getLastOrNull();

  List<BloodSugar> getBloodSugar() =>
      _hiveBoxes.bloodSugarBox.values.toList().getLastOrNull();

  List<HeightModel> getHeightModel() =>
      _hiveBoxes.heightModelBox.values.toList().getLastOrNull();

  List<Pulse> getPulse() => _hiveBoxes.pulseBox.values.toList().getLastOrNull();

  List<Temperature> getTemperature() =>
      _hiveBoxes.temperatureBox.values.toList().getLastOrNull();

  void saveArterialPressure({ArterialPressure pulse}) {}

  void savePulse({Pulse pulse}) {}

  void bloodBloodSugar({BloodSugar pulse}) {}

  void saveTemperature({Temperature pulse}) {}

  fetchMeasurementList() {
    return [];
  }

  Iterable<int> fetchMeasurementTypeList() {
    return [];
  }

  void saveMeasure() {}
}
