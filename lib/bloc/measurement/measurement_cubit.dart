import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/measurement/measurement_state.dart';
import 'package:emma_mobile/data/repositories/measurement_local_repository.dart';

class MeasurementCubit extends Cubit<MeasurementState> {
  MeasurementCubit(this.repository) : super(LoadingMeasurementState()) {
    _init();
  }

  final MeasurementLocalRepository repository;

  void _init() {
    fetchMeasurementTypedList();
    fetchMeasurementList();
  }

  Future<void> fetchMeasurementList() async {
    try {
      final list = repository.fetchMeasurementList();
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

  void setCurrentMeasurementType() {}

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
