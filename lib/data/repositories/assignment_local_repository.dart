import 'package:emma_mobile/domain/repositories/assignment_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AssignmentRepository)
class AssignmentLocalRepository implements AssignmentRepository {

  @override
  Future<Iterable<String>> fetchAssignmentChipTypes() {
    final chipTypes = [
      'Принять',
      'Принято',
      'История'
    ];
    return Future.value(chipTypes);
  }

}