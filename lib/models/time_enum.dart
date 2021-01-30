import 'package:intl/intl.dart';

List<DateTimeType> dateTimeTypes = [
  HourDateTime(),
  DayDateTime(),
  WeekDateTime(),
  MonthDateTime(),
  YearDateTime(),
];

abstract class DateTimeType {
  String timeValue;

  int countOnPage;

  List<String> numbers({DateTime timeFrom});

  String formatter(DateTime timeFrom, DateTime timeTo);

  String leftFormatter({DateTime timeFrom});

  String rightFormatter({DateTime timeTo});

  double percentDate(DateTime time, {DateTime startDateTime});
}

class HourDateTime implements DateTimeType {
  @override
  int countOnPage = 4;

  @override
  List<String> numbers({DateTime timeFrom}) => [
        '0',
        '12',
        '24',
        '36',
        '48',
        '',
      ];

  @override
  String timeValue = 'Час';

  @override
  String formatter(DateTime timeFrom, DateTime timeTo) =>
      '${timeFrom.hour} - ${timeTo.hour}';

  @override
  double percentDate(DateTime time, {DateTime startDateTime}) {
    return time.minute / 60;
  }

  @override
  String leftFormatter({DateTime timeFrom}) {
    return DateFormat('dd LLL').format(timeFrom);
  }

  @override
  String rightFormatter({DateTime timeTo}) {
    return '';
  }
}

class DayDateTime implements DateTimeType {
  @override
  int countOnPage = 4;

  @override
  List<String> numbers({DateTime timeFrom}) =>
      ['0', '4', '8', '12', '16', '20', '24'];

  @override
  String timeValue = 'День';

  @override
  String formatter(DateTime timeFrom, DateTime timeTo) {
    final now = DateTime.now();
    if (timeTo.year == now.year &&
        timeTo.month == now.month &&
        timeTo.day == now.day) {
      return 'Сегодня';
    } else {
      return DateFormat('dd MMM').format(timeTo);
    }
  }

  @override
  double percentDate(DateTime time, {DateTime startDateTime}) {
    final sum = (time.hour * 60 + time.minute) / 60;
    return sum / 24;
  }

  @override
  String leftFormatter({DateTime timeFrom}) {
    return DateFormat('dd LLL').format(timeFrom);
  }

  @override
  String rightFormatter({DateTime timeTo}) {
    return DateFormat('dd LLL').format(timeTo.add(const Duration(days: 1)));
  }
}

class WeekDateTime implements DateTimeType {
  @override
  int countOnPage = 2;

  @override
  List<String> numbers({DateTime timeFrom}) {
    final List<String> data = [];
    for (var i = 0; i <= 7; i++) {
      data.add(DateFormat('E').format(timeFrom.add(Duration(days: i))));
    }
    return data;
  }

  @override
  String timeValue = 'Неделя';

  @override
  String formatter(DateTime timeFrom, DateTime timeTo) {
    final lastDate = DateFormat('dd MMM').format(timeTo);
    final firstDate =
        DateFormat(timeFrom.month == timeTo.month ? 'dd' : 'dd MMM')
            .format(timeFrom);
    return '$firstDate - $lastDate';
  }

  @override
  double percentDate(DateTime time, {DateTime startDateTime}) {
    final period = startDateTime.difference(time);
    return period.inHours / 24 / 7;
  }

  @override
  String leftFormatter({DateTime timeFrom}) {
    return DateFormat('dd LLL').format(timeFrom);
  }

  @override
  String rightFormatter({DateTime timeTo}) {
    return DateFormat('dd LLL').format(timeTo);
  }
}

class MonthDateTime implements DateTimeType {
  @override
  int countOnPage = 4;

  @override
  List<String> numbers({DateTime timeFrom}) => ['1', '7', '13', '19', '25', ''];

  @override
  String timeValue = 'Месяц';

  @override
  String formatter(DateTime timeFrom, DateTime timeTo) =>
      DateFormat('MMM yyyy').format(timeFrom);

  @override
  double percentDate(DateTime time, {DateTime startDateTime}) {
    final lastDay = DateTime(time.year, time.month + 1, 0).day;
    return time.day / lastDay;
  }

  @override
  String leftFormatter({DateTime timeFrom}) {
    return DateFormat('dd LLL yyyy').format(timeFrom);
  }

  @override
  String rightFormatter({DateTime timeTo}) {
    return DateFormat('dd LLL yyyy').format(timeTo);
  }
}

class YearDateTime implements DateTimeType {
  @override
  int countOnPage = 4;

  @override
  List<String> numbers({DateTime timeFrom}) => [
        'Я',
        'Ф',
        'М',
        'А',
        'М',
        'И',
        'И',
        'А',
        'С',
        'О',
        'Н',
        'Д',
      ];

  @override
  String timeValue = 'Год';

  @override
  String formatter(DateTime timeFrom, DateTime timeTo) =>
      timeTo.year.toString();

  @override
  double percentDate(DateTime time, {DateTime startDateTime}) {
    final lastDay = DateTime(time.year, time.month + 1, 0).day;
    return time.month / 12 + (time.day / lastDay / 12) + 0.01;
  }

  @override
  String leftFormatter({DateTime timeFrom}) {
    return DateFormat('LLL yyyy').format(timeFrom);
  }

  @override
  String rightFormatter({DateTime timeTo}) {
    return DateFormat('LLL yyyy').format(timeTo);
  }
}
