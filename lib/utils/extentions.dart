import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:intl/intl.dart';

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

extension DateTimeExtentions on DateTime {
  String measurementDateFormatter() {
    final now = DateTime.now();
    if (now.year == year && now.month == month && now.day == day) {
      return 'Сегодня ${DateFormat.Hm().format(this)}';
    } else {
      return DateFormat('dd.MM.yyyy HH:mm').format(this);
    }
  }
}

extension IntExtention on int {
  String get twoDigits {
    if (this >= 10)
      return toString();
    return '0$this';
  }
}
