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

  DateTimeType _type = dateTimeTypes[1];

  TimeRange _activeTimeRange;

  List<TimeRange> _ranges;

  DateTimeType get type => _type;

  String _min = '';

  String _max = '';

  String get min => _min;

  String get max => _max;

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
    _calcMinMax();
  }

  void deleteItem({Measurement measurement}) {
    _data = _data.where((e) => e.dateTime != measurement.dateTime).toList();
    emit(MeasurementDetailState());
  }

  void setDateType(DateTimeType type) {
    _type = type;
    _updateTimeRange();
    _calcMinMax();
    emit(MeasurementDetailState());
  }

  void setTimeRange(TimeRange timeRange) {
    _activeTimeRange = timeRange;
    _calcMinMax();
    emit(MeasurementDetailState());
  }

  // какой-то треш получился, но я хз как по другому, все портит давление
  void _calcMinMax() {
    if (_data.isEmpty)
      return;
    if (_measurement is ArterialPressure) {
      final data = _data.map((e) => e as ArterialPressure).toList();
      data.sort((i, j) => i.under.compareTo(j.under));
      _min = data.first.under.toString();
      _max = data.last.under.toString();
      data.sort((i, j) => i.top.compareTo(j.top));
      _min = '$_min/${data.first.top}';
      _max = '$_max/${data.last.top}';
    } else if (_measurement is BloodSugar) {
      final data = _data.map((e) => e as BloodSugar).toList();
      data.sort((i, j) => i.sugar.compareTo(j.sugar));
      _min = data.first.sugar.toString();
      _max = data.last.sugar.toString();
    } else if (_measurement is HeightModel) {
      final data = _data.map((e) => e as HeightModel).toList();
      data.sort((i, j) => i.height.compareTo(j.height));
      _min = data.first.height.toString();
      _max = data.last.height.toString();
    } else if (_measurement is Pulse) {
      final data = _data.map((e) => e as Pulse).toList();
      data.sort((i, j) => i.pulse.compareTo(j.pulse));
      _min = data.first.pulse.toString();
      _max = data.last.pulse.toString();
    } else if (_measurement is Temperature) {
      final data = _data.map((e) => e as Temperature).toList();
      data.sort((i, j) => i.temperature.compareTo(j.temperature));
      _min = data.first.temperature.toString();
      _max = data.last.temperature.toString();
    }
  }

  void reload() {
    _init();
    emit(MeasurementDetailState());
  }
}
