import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/measurement/measurement_state.dart';
import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/repositories/measurement_local_repository.dart';
import 'package:emma_mobile/utils/utils.dart';

class MeasurementCubit extends Cubit<MeasurementState> {
  MeasurementCubit(this._repository) : super(LoadingMeasurementState()) {
    _init();
  }

  final MeasurementLocalRepository _repository;

  ArterialPressure _arterialPressure;
  BloodSugar _bloodSugar;
  HeightModel _heightModel;
  Pulse _pulse;
  Temperature _temperature;

  ArterialPressure get arterialPressure => _arterialPressure;

  BloodSugar get bloodSugar => _bloodSugar;

  HeightModel get heightModel => _heightModel;

  Pulse get pulse => _pulse;

  Temperature get temperature => _temperature;

  bool get isEmptyData =>
      _arterialPressure == null &&
      _bloodSugar == null &&
      _heightModel == null &&
      _pulse == null &&
      _temperature == null;

  List<Measurement> get data => [
        _arterialPressure,
        _bloodSugar,
        _heightModel,
        _pulse,
        _temperature,
      ].where((e) => e != null).map((e) => e as Measurement).toList();

  void _init() {
    _getLastValues();
  }

  void _getLastValues() {
    _arterialPressure = _repository.getArterialPressure()?.getLastOrNull();
    _bloodSugar = _repository.getBloodSugar()?.getLastOrNull();
    _heightModel = _repository.getHeightModel()?.getLastOrNull();
    _pulse = _repository.getPulse()?.getLastOrNull();
    _temperature = _repository.getTemperature()?.getLastOrNull();
  }
}
