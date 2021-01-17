import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';

class MeasurementLocalRepository {
  final _hiveBoxes = HiveBoxes();

  List<ArterialPressure> getArterialPressure() =>
      _hiveBoxes.arterialPressureBox.values
          .map((e) => e as ArterialPressure)
          .toList();

  List<BloodSugar> getBloodSugar() =>
      _hiveBoxes.bloodSugarBox.values.map((e) => e as BloodSugar).toList();

  List<HeightModel> getHeightModel() =>
      _hiveBoxes.heightModelBox.values.map((e) => e as HeightModel).toList();

  List<Pulse> getPulse() {
    return _hiveBoxes.pulseBox.values.map((e) => e as Pulse).toList();
  }

  List<Temperature> getTemperature() =>
      _hiveBoxes.temperatureBox.values.map((e) => e as Temperature).toList();

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
