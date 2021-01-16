class AssignmentLocalRepository {
  Future<Iterable<String>> fetchAssignmentChipTypes() {
    final chipTypes = ['Принять', 'Принято', 'История'];
    return Future.value(chipTypes);
  }
}
