import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:emma_mobile/bloc/assignment/assignment_state.dart';
import 'package:emma_mobile/domain/repositories/assignment_repository.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit(this.repository) : super(AssignmentState());

  final AssignmentRepository repository;

  void init() {
    _fetchAssignmentChipTypes();
  }

  Future<void> _fetchAssignmentChipTypes() async {
    final types = await repository.fetchAssignmentChipTypes();
    emit(
      state.rebuild(
        (s) => {
          s.assignChipTypes = ListBuilder<String>(types),
          s.currentTypeChip = types.first
        },
      ),
    );
  }
}
