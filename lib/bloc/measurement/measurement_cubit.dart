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

  List<Measurement> get data =>
      _rawData.where((e) => e != null).map((e) => e as Measurement).toList()
        ..sort(
          (i, j) => j.dateTime.compareTo(i.dateTime),
        );

  List<Measurement> get _rawData => [
        _arterialPressure,
        _bloodSugar,
        _heightModel,
        _pulse,
        _temperature,
      ];

  void _init() {
    _getLastValues();
  }

  void updateLastValueByMeasurementType(Measurement type) {
    _getLastValueByIndex(
      _rawData.lastIndexWhere((e) => e.runtimeType == type.runtimeType),
    );
    emit(DataMeasurementState());
  }

  void _getLastValues() {
    for (var i = 0; i < _rawData.length; i++) {
      _getLastValueByIndex(i);
    }
  }

  void _getLastValueByIndex(int index) {
    if (index == 0) {
      _arterialPressure = _repository.getArterialPressure()?.getLastByDate();
    } else if (index == 1) {
      _bloodSugar = _repository.getBloodSugar()?.getLastByDate();
    } else if (index == 2) {
      _heightModel = _repository.getHeightModel()?.getLastByDate();
    } else if (index == 3) {
      _pulse = _repository.getPulse()?.getLastByDate();
    } else if (index == 3) {
      _temperature = _repository.getTemperature()?.getLastByDate();
    }
  }
}
