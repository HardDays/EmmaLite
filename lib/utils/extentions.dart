import 'package:emma_mobile/models/measurements/measurement.dart';

extension ListExtention on List {
  dynamic getLastOrNull() {
    return isEmpty ? null : last;
  }

  dynamic getLastByDate() {
    if (getLastOrNull() != null) {
      if (last is Measurement) {
        final list = this as List<Measurement>;
        list.sort((i, j) => i.dateTime.compareTo(j.dateTime));
        return list.last;
      } else {
        return last;
      }
    } else {
      return null;
    }
  }
}
