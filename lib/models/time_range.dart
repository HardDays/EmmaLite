import 'package:emma_mobile/models/time_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class TimeRange extends Equatable {
  final DateTimeType type;
  final DateTime timeFrom;
  final DateTime timeTo;

  const TimeRange({this.type, this.timeFrom, this.timeTo});

  @override
  String toString() {
    if (type == DateTimeType.year) {
      return yearFormatter();
    } else if (type == DateTimeType.month) {
      return monthFormatter();
    } else if (type == DateTimeType.week) {
      return weekFormatter();
    } else if (type == DateTimeType.day) {
      return dayFormatter();
    } else if (type == DateTimeType.hour) {
      return hourFormatter();
    }
    return '$timeFrom - $timeTo';
  }

  String yearFormatter() => timeTo.year.toString();

  String monthFormatter() => DateFormat('MMM yyyy').format(timeFrom);

  String weekFormatter() {
    final lastDate = DateFormat('dd MMM').format(timeTo);
    final firstDate =
        DateFormat(timeFrom.month == timeTo.month ? 'dd' : 'dd MMM')
            .format(timeFrom);
    return '$firstDate - $lastDate';
  }

  String dayFormatter() {
    final now = DateTime.now();
    if (timeTo.year == now.year &&
        timeTo.month == now.month &&
        timeTo.day == now.day) {
      return 'Сегодня';
    } else {
      return DateFormat('dd MMM').format(timeTo);
    }
  }

  String hourFormatter() => '${timeFrom.hour} - ${timeTo.hour}';

  @override
  List<Object> get props => [type, timeFrom, timeTo];
}
