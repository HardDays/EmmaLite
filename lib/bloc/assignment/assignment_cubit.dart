import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/assignment/assignment_state.dart';
import 'package:emma_mobile/data/repositories/assignment_local_repository.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit(this.repository) : super(LoadingAssignmentState()) {
    init();
  }

  final AssignmentLocalRepository repository;

  void init() {
    _fetchAssignmentChipTypes();
  }

  Future<void> _fetchAssignmentChipTypes() async {
    final types = await repository.fetchAssignmentChipTypes();
  }
}
