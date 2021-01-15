import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/main/main_state.dart';
import 'package:emma_mobile/domain/repositories/main_repository.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.repository) : super(LoadingMainState()) {
    init();
  }
  final MainRepository repository;

  void init() {
    fetchMeasurementList();
  }

  Future<void> fetchMeasurementList() async {
    try {
      final list = await repository.fetchMeasurementList();
    } catch (e) {
      print(e);
    }
  }
}
