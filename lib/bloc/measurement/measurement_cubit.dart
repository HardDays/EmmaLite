import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:emma_mobile/bloc/measurement/measurement_state.dart';
import 'package:emma_mobile/domain/common/async_field.dart';
import 'package:emma_mobile/domain/model/measurements/measurement.dart';
import 'package:emma_mobile/domain/model/measurements/measurement_type.dart';
import 'package:emma_mobile/domain/repositories/measurement_repository.dart';

class MeasurementCubit extends Cubit<MeasurementState> {
  MeasurementCubit(this.repository) : super(MeasurementState());

  final MeasurementRepository repository;

  void init() {
    fetchMeasurementTypedList();
    fetchMeasurementList();
  }

  Future<void> fetchMeasurementList() async {
    try {
      emit(
        state.rebuild(
          (s) => s.measurementList
              .replace(AsyncField<BuiltList<Measurement>>.inProgress()),
        ),
      );
      final list = await repository.fetchMeasurementList();
      emit(
        state.rebuild(
          (s) => s.measurementList.replace(
              AsyncField<BuiltList<Measurement>>.success(BuiltList.from(list))),
        ),
      );
    } catch (error) {
      emit(
        state.rebuild(
          (s) => s.measurementList
              .replace(AsyncField<BuiltList<Measurement>>.error(error)),
        ),
      );
    }
  }

  Future<void> fetchMeasurementTypedList() async {
    try {
      emit(
        state.rebuild(
          (s) => s.measurementTypes.replace(
            AsyncField<BuiltList<MeasurementType>>.inProgress(),
          ),
        ),
      );
      final list = await repository.fetchMeasurementTypeList();
      emit(
        state.rebuild(
          (s) => s.measurementTypes.replace(
            AsyncField<BuiltList<MeasurementType>>.success(
              BuiltList.from(list),
            ),
          ),
        ),
      );
    } catch (error) {
      emit(
        state.rebuild(
          (s) => s.measurementTypes.replace(
            AsyncField<BuiltList<MeasurementType>>.error(error),
          ),
        ),
      );
    }
  }

  void setCurrentMeasurementType(MeasurementType type) {
    emit(state.rebuild((s) => s.currentType = type));
  }

  Future<void> saveMeasurement(String date, String title, String value) async {
    try {
      emit(
        state.rebuild(
          (s) => s.isSaved.replace(AsyncField<bool>.inProgress()),
        ),
      );
      await repository.saveMeasure(date, state.currentType, title, value);
      emit(
        state.rebuild(
          (s) => s.isSaved.replace(AsyncField<bool>.success(true)),
        ),
      );
      fetchMeasurementList();
      dispose();
    } catch (error) {
      emit(
        state.rebuild(
          (s) => s.isSaved.replace(AsyncField<bool>.error(error)),
        ),
      );
    }
  }

  void dispose() {
    emit(
      state.rebuild((s) => s.isSaved.replace(null)),
    );
  }
}
