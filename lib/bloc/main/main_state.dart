import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:emma_mobile/domain/common/async_field.dart';
import 'package:emma_mobile/domain/model/measurements/measurement.dart';

part 'main_state.g.dart';

abstract class MainState implements Built<MainState, MainStateBuilder> {

  factory MainState([void Function(MainStateBuilder) updates]) = _$MainState;

  MainState._();

  @nullable
  AsyncField<BuiltList<Measurement>> get measurementList;
}