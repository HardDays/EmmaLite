import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_state.dart';
import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/models/time_enum.dart';
import 'package:emma_mobile/models/time_range.dart';
import 'package:emma_mobile/repositories/measurement_local_repository.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementDetailBloc extends Cubit<MeasurementDetailState> {
  MeasurementDetailBloc({Measurement measurement})
      : _measurement = measurement,
        super(MeasurementDetailState()) {
    _init();
  }

  final Measurement _measurement;

  final _repository = MeasurementLocalRepository();

  Measurement get item => _measurement;

  List<Measurement> _data;

  DateTimeType _type = DateTimeType.day;

  TimeRange _activeTimeRange;

  List<TimeRange> _ranges;

  DateTimeType get type => _type;

  List<Measurement> get data => _data
      .where((e) =>
          e.dateTime.isAfter(_activeTimeRange.timeFrom) &&
          e.dateTime.isBefore(_activeTimeRange.timeTo))
      .toList();

  TimeRange get activeTimeRange => _activeTimeRange;

  List<TimeRange> get ranges => _ranges;

  void _init() {
    if (_measurement is ArterialPressure) {
      _data = _repository.getArterialPressure();
    } else if (_measurement is BloodSugar) {
      _data = _repository.getBloodSugar();
    } else if (_measurement is HeightModel) {
      _data = _repository.getHeightModel();
    } else if (_measurement is Pulse) {
      _data = _repository.getPulse();
    } else if (_measurement is Temperature) {
      _data = _repository.getTemperature();
    }
    _updateTimeRange();
  }

  void _updateTimeRange() {
    _ranges = Static.getTimeRange(type: _type);
    _activeTimeRange = _ranges.first;
  }

  void setDateType(DateTimeType type) {
    _type = type;
    _updateTimeRange();
    emit(MeasurementDetailState());
  }

  void setTimeRange(TimeRange timeRange) {
    _activeTimeRange = timeRange;
    emit(MeasurementDetailState());
  }
}
