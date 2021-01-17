import 'package:emma_mobile/bloc/new_measurement_bloc/new_measurement_state.dart';
import 'package:emma_mobile/models/measurements/measurement_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewMeasurementBloc extends Cubit<NewMeasurementState> {
  NewMeasurementBloc({MeasurementEnum type})
      : _type = type,
        super(NewMeasurementState());

  MeasurementEnum _type;

  MeasurementEnum get type => _type;

  void setType({MeasurementEnum type}) {
    _type = type;
    emit(NewMeasurementState());
  }


  void save() {}
}
