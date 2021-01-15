import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:emma_mobile/domain/common/async_field.dart';
import 'package:emma_mobile/domain/model/measurements/measurement.dart';
import 'package:emma_mobile/domain/model/measurements/measurement_type.dart';

part 'measurement_state.g.dart';

abstract class MeasurementState
    implements Built<MeasurementState, MeasurementStateBuilder> {
  factory MeasurementState([void Function(MeasurementStateBuilder) updates]) =
      _$MeasurementState;

  MeasurementState._();

  @nullable
  AsyncField<BuiltList<Measurement>> get measurementList;

  @nullable
  AsyncField<BuiltList<MeasurementType>> get measurementTypes;

  @nullable
  AsyncField<bool> get isSaved;

  @nullable
  MeasurementType get currentType;
}
