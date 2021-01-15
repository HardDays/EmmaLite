import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:emma_mobile/domain/common/async_field.dart';
import 'package:emma_mobile/domain/model/assignment/assignment.dart';

part 'assignment_state.g.dart';

abstract class AssignmentState
    implements Built<AssignmentState, AssignmentStateBuilder> {

  factory AssignmentState([void Function(AssignmentStateBuilder) updates]) =
      _$AssignmentState;

  AssignmentState._();

  @nullable
  AsyncField<BuiltList<Assignment>> get assignmentList;

  @nullable
  BuiltList<String> get assignmentTypes;

  @nullable
  BuiltList<String> get unitsName;

  @nullable
  BuiltList<String> get frequencies;

  @nullable
  BuiltList<String> get periodicity;

  @nullable
  String get currentTypeChip;

  @nullable
  BuiltList<String> get assignChipTypes;
}
