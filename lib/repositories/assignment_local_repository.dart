import 'package:emma_mobile/models/assignment/assignment.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';

class AssignmentLocalRepository {
  final _hiveBoxes = HiveBoxes();

  final _appLocalRepository = AppLocalRepository();

  List<Assignment> getAssignment() {
    final userId = _appLocalRepository.currentUserId;
    return _hiveBoxes.assignmentBox.values
        .map((e) => Assignment.fromJson(e))
        .where((e) => e.userId == userId)
        .toList();
  }

  List<Assignment> getAllAssignment() {
    return _hiveBoxes.assignmentBox.values
        .map((e) => Assignment.fromJson(e))
        .toList();
  }

  void addAssignment(Assignment assign) =>
      _hiveBoxes.assignmentBox.add(assign.toJson());

  void insert({Assignment assign}) {
    final index = _getIndexById(id: assign.id);
    _hiveBoxes.assignmentBox.putAt(index, assign.toJson());
  }

  void removeById({int id}) {
    final index = _getIndexById(id: id);
    _hiveBoxes.assignmentBox.deleteAt(index);
  }

  int _getIndexById({int id}) {
    return _hiveBoxes.assignmentBox.values
        .map((e) => Assignment.fromJson(e))
        .toList()
        .lastIndexWhere((e) => e.id == id);
  }
}
