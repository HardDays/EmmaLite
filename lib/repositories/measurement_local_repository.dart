import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';

//SOLID где-то плачет в сторонке, но жизнь такова и больше никакова
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
      _hiveBoxes.arterialPressureBox.deleteAt(index);
    } else if (meas.runtimeType == BloodSugar(date: date).runtimeType) {
      _hiveBoxes.bloodSugarBox.deleteAt(index);
    } else if (meas.runtimeType == Pulse(date: date).runtimeType) {
      _hiveBoxes.pulseBox.deleteAt(index);
    } else if (meas.runtimeType == HeightModel(date: date).runtimeType) {
      _hiveBoxes.heightModelBox.deleteAt(index);
    } else if (meas.runtimeType == Temperature(date: date).runtimeType) {
      _hiveBoxes.temperatureBox.deleteAt(index);
    }
  }
}
