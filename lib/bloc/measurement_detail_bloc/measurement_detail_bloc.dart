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
  MeasurementDetailBloc({Measurement measurement, bool isMock = false})
      : _measurement = measurement,
        super(MeasurementDetailState()) {
    if (isMock) {
      _data = [];
      for (var i = 0; i < 5; i++) {
        _data.add(
          Temperature(
            date: DateTime(1970).add(Duration(days: i * 2)).toString(),
            temperature: 36.8 - i,
          ),
        );
      }
      _activeTimeRange = TimeRange(
        type: MonthDateTime(),
        timeFrom: _data.first.dateTime,
        timeTo: _data.last.dateTime,
      );
      _type = WeekDateTime();
    } else {
      _type = dateTimeTypes[1];
      _init();
    }
  }

  final Measurement _measurement;

  final _repository = MeasurementLocalRepository();

  Measurement get item => _measurement;

  List<Measurement> _data;

  DateTimeType _type;

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
      .toList()..sort((i, j) => j.dateTime.compareTo(i.dateTime));

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
    if (_data.isEmpty) return;
    if (_measurement is ArterialPressure) {
      final items = data.map((e) => e as ArterialPressure).toList();
      items.sort((i, j) => i.under.compareTo(j.under));
      if (items.isNotEmpty) {
        _min = items.first.under.toInt().toString();
        _max = items.last.under.toInt().toString();
        items.sort((i, j) => i.top.compareTo(j.top));
        _min = '$_min/${items.first.top}';
        _max = '$_max/${items.last.top}';
      }
    } else if (_measurement is BloodSugar) {
      final items = data.map((e) => e as BloodSugar).toList();
      items.sort((i, j) => i.sugar.compareTo(j.sugar));
      if (items.isNotEmpty) {
        _min = items.first.sugar.toStringAsFixed(1);
        _max = items.last.sugar.toStringAsFixed(1);
      }
    } else if (_measurement is HeightModel) {
      final items = data.map((e) => e as HeightModel).toList();
      items.sort((i, j) => i.height.compareTo(j.height));
      if (items.isNotEmpty) {
        _min = items.first.height.toStringAsFixed(1);
        _max = items.last.height.toStringAsFixed(1);
      }
    } else if (_measurement is Pulse) {
      final items = data.map((e) => e as Pulse).toList();
      items.sort((i, j) => i.pulse.compareTo(j.pulse));
      if (items.isNotEmpty) {
        _min = items.first.pulse.toInt().toString();
        _max = items.last.pulse.toInt().toString();
      }
    } else if (_measurement is Temperature) {
      final items = data.map((e) => e as Temperature).toList();
      items.sort((i, j) => i.temperature.compareTo(j.temperature));
      if (items.isNotEmpty) {
        _min = items.first.temperature.toStringAsFixed(1);
        _max = items.last.temperature.toStringAsFixed(1);
      }
    }
  }

  void reload() {
    _init();
    emit(MeasurementDetailState());
  }
}
