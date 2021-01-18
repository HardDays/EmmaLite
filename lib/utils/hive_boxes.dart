import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:hive/hive.dart';

class HiveBoxes {
  static HiveBoxes _instance;

  Box<ArterialPressure> _arterialPressure;
  Box<BloodSugar> _bloodSugar;
  Box<HeightModel> _heightModel;
  Box<Pulse> _pulse;
  Box<Temperature> _temperature;

  Box<Temperature> get temperatureBox => _temperature;

  Box<ArterialPressure> get arterialPressureBox => _arterialPressure;

  Box<BloodSugar> get bloodSugarBox => _bloodSugar;

  Box<HeightModel> get heightModelBox => _heightModel;

  Box<Pulse> get pulseBox => _pulse;

  factory HiveBoxes() {
    _instance ??= HiveBoxes._();
    return _instance;
  }

  HiveBoxes._();

  Future<void> init() async {
    // final z = await Hive.openBox<Pulse>('Pulse');
    // final a = z.values;
    // print(a);
    // z.add(Pulse()..id = 1..date = DateTime.now().toString()..pulse = 200);
    // List<Pulse> w = a.map((e) => e as Pulse).toList();
    // for (var i in a) {
    //   print(i);
    // }
    _arterialPressure =
        await Hive.openBox<ArterialPressure>('ArterialPressure');
    _bloodSugar = await Hive.openBox<BloodSugar>('BloodSugar');
    _heightModel = await Hive.openBox<HeightModel>('HeightModel');
    _pulse = await Hive.openBox<Pulse>('Pulse');
    _temperature = await Hive.openBox<Temperature>('Temperature');
  }
}
