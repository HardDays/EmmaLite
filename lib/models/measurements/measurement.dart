import 'package:emma_mobile/models/measurements/measurement_enum.dart';

abstract class Measurement {

  String title;

  String longTitle;

  String addTitle;

  String value();

  String getFormattedDate();

  String units;

  MeasurementEnum type;

  DateTime dateTime;

  int getUserId();

}
