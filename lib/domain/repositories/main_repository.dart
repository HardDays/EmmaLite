import 'package:emma_mobile/domain/model/measurements/measurement.dart';

abstract class MainRepository {
  Future<Iterable<Measurement>> fetchMeasurementList();
}