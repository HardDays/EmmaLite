import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/utils/utils.dart';
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
      return '${'titleTodayText'.tr} ${DateFormat.Hm().format(this)}';
    } else {
      return DateFormat('dd.MM.yyyy HH:mm').format(this);
    }
  }

  String get assignScreenFormatter {
    final now = DateTime.now();
    if (now.year == year && now.month == month && now.day == day) {
      return 'titleTodayText'.tr;
    } else {
      return DateFormat('d MMMM').format(this);
    }
  }

  DateTime copyWith({
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
    );
  }

  bool isInDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool getInDayInRange({
    DateTime startDate,
    DateTime endDate,
  }) {
    return year >= startDate.year &&
        year <= endDate.year &&
        month >= startDate.month &&
        month <= endDate.month &&
        day >= startDate.day &&
        day <= endDate.day;
  }
}

extension IntExtention on int {
  String get twoDigits {
    if (this >= 10) {
      return toString();
    }
    return '0$this';
  }

  String get getPluralHour {
    final lastSymbol = this.lastSymbol;
    final hour = abs();
    if (lastSymbol == 1 && lastThoSymbol != 11) {
      return 'hoursText_1'.tr; // час
    }
    if (hour == 11 || hour == 12 || hour == 13 || hour == 14) {
      return 'hoursText_3'.tr;
    }
    if (lastSymbol == 2 || lastSymbol == 3 || lastSymbol == 4) {
      return 'hoursText_2'.tr; // часа
    }
    return 'hoursText_3'.tr; // часов
  }

  String get getPluralMinutes {
    final lastSymbol = this.lastSymbol;
    final minutes = abs();
    if (minutes == 11 || minutes == 12 || minutes == 13 || minutes == 14) {
      return 'minutesText_3'.tr;
    }
    if (lastSymbol == 1) {
      return 'minutesText_1'.tr;
    }
    if (lastSymbol == 2 || lastSymbol == 3 || lastSymbol == 4) {
      return 'minutesText_2'.tr;
    }
    return 'minutesText_3'.tr;
  }

  int get lastSymbol {
    final lastSymbol = toString()[toString().length - 1];
    return int.parse(lastSymbol);
  }

  int get lastThoSymbol {
    if (this < 10) {
      return this;
    }
    final length = toString().length;
    final lastSymbols = toString().substring(length - 2, length);
    return int.parse(lastSymbols);
  }

  String get getPluralCountTitle {
    final lastSymbol = this.lastSymbol;
    if (lastSymbol == 1 && lastThoSymbol != 11) {
      return 'receptionsStayed_1'.tr;
    }
    return 'receptionsStayed_2'.tr;
  }

  String get getPluralCount {
    final lastSymbol = this.lastSymbol;
    final lastThoSymbol = this.lastThoSymbol;
    if (lastSymbol == 1 && lastThoSymbol != 11) {
      return 'receptionsReception_1'.tr;
    }
    if (lastThoSymbol == 11 ||
        lastThoSymbol == 12 ||
        lastThoSymbol == 13 ||
        lastThoSymbol == 14) {
      return 'receptionsReception_3'.tr;
    }
    if (lastSymbol == 2 || lastSymbol == 3 || lastSymbol == 4) {
      return 'receptionsReception_2'.tr;
    }
    return 'receptionsReception_3'.tr;
  }

  String get getPluralDays {
    final lastSymbol = this.lastSymbol;
    final lastThoSymbol = this.lastThoSymbol;
    if (lastSymbol == 1 && lastThoSymbol != 11) {
      return 'daysText_1'.tr;
    }
    if (lastThoSymbol == 11 ||
        lastThoSymbol == 12 ||
        lastThoSymbol == 13 ||
        lastThoSymbol == 14) {
      return 'daysText_3'.tr;
    }
    if (lastSymbol == 2 || lastSymbol == 3 || lastSymbol == 4) {
      return 'daysText_2'.tr;
    }
    return 'daysText_3'.tr;
  }

  String get getPluralYears {
    final lastSymbol = this.lastSymbol;
    final lastThoSymbol = this.lastThoSymbol;
    if (lastSymbol == 1 && lastThoSymbol != 11) {
      return '1old'.tr;
    }
    if (lastThoSymbol == 11 ||
        lastThoSymbol == 12 ||
        lastThoSymbol == 13 ||
        lastThoSymbol == 14) {
      return '056789111213141516171819old'.tr;
    }
    if (lastSymbol == 2 || lastSymbol == 3 || lastSymbol == 4) {
      return '234old'.tr;
    }
    return '056789111213141516171819old'.tr;
  }
}

extension StringExtentions on String {
  String get first => substring(0, 1);
}
