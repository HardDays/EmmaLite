import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:emma_mobile/bloc/main/main_state.dart';
import 'package:emma_mobile/domain/common/async_field.dart';
import 'package:emma_mobile/domain/model/measurements/measurement.dart';
import 'package:emma_mobile/domain/repositories/main_repository.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.repository) : super(MainState());
  final MainRepository repository;

  void init() {
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
}
