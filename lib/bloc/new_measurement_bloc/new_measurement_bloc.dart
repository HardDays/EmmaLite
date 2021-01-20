import 'package:emma_mobile/bloc/new_measurement_bloc/new_measurement_state.dart';
import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewMeasurementBloc extends Cubit<NewMeasurementState> {
  NewMeasurementBloc({Measurement type})
      : _type = type,
        super(NewMeasurementState()) {
    _dateTime = DateTime.now();
    _enable = _type is BloodSugar || _type is Temperature;
  }

  final Measurement _type;

  Measurement get type => _type;

  bool _enable = false;

  bool get enable => _enable;

  DateTime _dateTime;

  DateTime get dateTime => _dateTime;

  int _artPressureMin;
  int _artPressureMax;

  int _pulseType;
  int _pulse;

  int get pulseType => _pulseType;

  int _height;

  double _sugar = 4.0;
  DateTime _eatTime;

  double get sugar => _sugar;

  DateTime get eatTime => _eatTime;

  double _temperature = 36.6;

  double get temperature => _temperature;

  void setDateTime(DateTime dateTime) {
    _dateTime = dateTime;
    emit(NewMeasurementState());
  }


  void setArtPressureMin(String v) {
    if (v.isNotEmpty) {
      _artPressureMin = int.parse(v);
    } else {
      _artPressureMin = null;
    }
    _checkEnable();
  }

  void setArtPressureMax(String v) {
    if (v.isNotEmpty) {
      _artPressureMax = int.parse(v);
    } else {
      _artPressureMax = null;
    }
    _checkEnable();
  }

  void setPulseType({int type}) {
    _pulseType = type;
    emit(NewMeasurementState());
    _checkEnable();
  }

  void setPulse(String v) {
    if (v.isNotEmpty) {
      _pulse = int.parse(v);
    } else {
      _pulse = null;
    }
    _checkEnable();
  }

  void setHeight(String v) {
    if (v.isNotEmpty) {
      _height = int.parse(v);
    } else {
      _height = null;
    }
    _checkEnable();
  }

  void setSugar(double v) {
    _sugar = v;
    emit(NewMeasurementState());
  }

  void setEatTime(DateTime v) {
    _eatTime = v;
    emit(NewMeasurementState());
  }

  void setTemperature(double v) {
    _temperature = v;
    emit(NewMeasurementState());
  }


  void _checkEnable() {
    bool enable = false;
    if (_type is ArterialPressure) {
      if (_artPressureMin != null && _artPressureMax != null) {
        enable = true;
      }
    } else if (_type is HeightModel) {
      if (_height != null) {
        enable = true;
      }
    } else if (_type is Pulse) {
      if (_pulse != null && _pulseType != null) {
        enable = true;
      }
    } else if (_type is Pulse) {
      if (_pulse != null && _pulseType != null) {
        enable = true;
      }
    } else if (_type is BloodSugar || _type is Temperature) {
      enable = true;
    }

    if (enable != _enable) {
      _enable = enable;
      emit(NewMeasurementState());
    }
  }

  void save() {}
}
