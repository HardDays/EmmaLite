import 'package:emma_mobile/models/assignment/assignment.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';

class AssignmentLocalRepository {
  final _hiveBoxes = HiveBoxes();

  List<Assignment> getAssignment() => _hiveBoxes.assignmentBox.values
      .map((e) => Assignment.fromJson(e))
      .toList();

  void addAssignment(Assignment assign) =>
      _hiveBoxes.assignmentBox.add(assign.toJson());

  void insertByIndex({int index, Assignment assign}) {
    _hiveBoxes.assignmentBox.putAt(index, assign.toJson());
  }

  void removeByIndex({int index}) {
    _hiveBoxes.assignmentBox.deleteAt(index);
  }
}
