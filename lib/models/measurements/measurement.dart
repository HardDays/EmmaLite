import 'package:emma_mobile/models/measurements/measurement_enum.dart';

abstract class Measurement {

  String title;

  String longTitle;

  String value();

  String getFormattedDate({bool showTimeIfToday = false});

  String units;

  String inNewScreen;

  MeasurementEnum type;

  DateTime dateTime;

}
