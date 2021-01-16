import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/measurement/measurement_state.dart';
import 'package:emma_mobile/data/repositories/measurement_local_repository.dart';
import 'package:emma_mobile/models/measurements/measurement_type.dart';

class MeasurementCubit extends Cubit<MeasurementState> {
  MeasurementCubit(this.repository) : super(LoadingMeasurementState()) {
    init();
  }

  final MeasurementLocalRepository repository;

  void init() {
    fetchMeasurementTypedList();
    fetchMeasurementList();
  }

  Future<void> fetchMeasurementList() async {
    try {
      final list = await repository.fetchMeasurementList();
    } catch (e) {
      print(e);
      // emit(
      //   state.rebuild(
      //     (s) => s.measurementList
      //         .replace(AsyncField<BuiltList<Measurement>>.error(error)),
      //   ),
      // );
    }
  }

  Future<void> fetchMeasurementTypedList() async {
    try {
      final list = await repository.fetchMeasurementTypeList();
    } catch (e) {
      print(e);
      // emit(
      //   state.rebuild(
      //     (s) => s.measurementTypes.replace(
      //       AsyncField<BuiltList<MeasurementType>>.error(error),
      //     ),
      //   ),
      // );
    }
  }

  void setCurrentMeasurementType(MeasurementType type) {}

  Future<void> saveMeasurement(String date, String title, String value) async {
    try {
      // await repository.saveMeasure(date, state.currentType, title, value);
      fetchMeasurementList();
      dispose();
    } catch (e) {
      print(e);
      // emit(
      //   state.rebuild(
      //     (s) => s.isSaved.replace(AsyncField<bool>.error(error)),
      //   ),
      // );
    }
  }

  void dispose() {}
}
