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

  String get assignScreenFormatter {
    final now = DateTime.now();
    if (now.year == year && now.month == month && now.day == day) {
      return 'Сегодня';
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
    if (lastSymbol == 1 && lastThoSymbol != 11) {
      return 'час';
    }
    if (lastSymbol == 2 || lastSymbol == 3 || lastSymbol == 4) {
      return 'часа';
    }
    return 'часов';
  }

  String get getPluralMinutes {
    final lastSymbol = this.lastSymbol;
    final minutes = abs();
    if (minutes == 11 || minutes == 12 || minutes == 13 || minutes == 14) {
      return 'минут';
    }
    if (lastSymbol == 1) {
      return 'минуту';
    }
    if (lastSymbol == 2 || lastSymbol == 3 || lastSymbol == 4) {
      return 'минуты';
    }
    return 'минут';
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
      return 'Остался';
    }
    return 'Осталось';
  }

  String get getPluralCount {
    final lastSymbol = this.lastSymbol;
    final lastThoSymbol = this.lastThoSymbol;
    if (lastSymbol == 1 && lastThoSymbol != 11 ) {
      return 'прием';
    }
    if (lastThoSymbol == 12 || lastThoSymbol == 13 || lastThoSymbol == 14) {
      return 'приемов';
    }
    if (lastSymbol == 2 || lastSymbol == 3 || lastSymbol == 4) {
      return 'приема';
    }
    return 'приемов';
  }
}
