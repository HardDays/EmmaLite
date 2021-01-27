import 'package:emma_mobile/models/time_enum.dart';
import 'package:equatable/equatable.dart';

class TimeRange extends Equatable {
  final DateTimeType type;
  final DateTime timeFrom;
  final DateTime timeTo;

  const TimeRange({this.type, this.timeFrom, this.timeTo});

  @override
  String toString() => type.formatter(timeFrom, timeTo);

  @override
  List<Object> get props => [type, timeFrom, timeTo];
}
