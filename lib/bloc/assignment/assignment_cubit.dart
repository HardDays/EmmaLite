import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/assignment/assignment_state.dart';
import 'package:emma_mobile/domain/repositories/assignment_repository.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit(this.repository) : super(LoadingAssignmentState()) {
    init();
  }

  final AssignmentRepository repository;

  void init() {
    _fetchAssignmentChipTypes();
  }

  Future<void> _fetchAssignmentChipTypes() async {
    final types = await repository.fetchAssignmentChipTypes();
  }
}
