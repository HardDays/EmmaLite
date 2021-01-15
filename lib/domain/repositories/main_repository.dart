import 'package:emma_mobile/models/measurements/measurement.dart';

abstract class MainRepository {
  Future<Iterable<Measurement>> fetchMeasurementList();
}