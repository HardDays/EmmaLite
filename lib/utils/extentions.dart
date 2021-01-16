
extension ListExtention on List {


  dynamic getLastOrNull() {
    return isEmpty ? null : last;
  }
}
