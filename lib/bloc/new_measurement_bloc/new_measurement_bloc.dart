import 'package:emma_mobile/bloc/new_measurement_bloc/new_measurement_state.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewMeasurementBloc extends Cubit<NewMeasurementState> {
  NewMeasurementBloc({Measurement type})
      : _type = type,
        super(NewMeasurementState());

  final Measurement _type;

  Measurement get type => _type;

  int _artPressureMin;
  int _artPressureMax;

  void setArtPressureMin(String v) {}
  void setArtPressureMax(String v) {}

  void save() {}
}
