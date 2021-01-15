import 'package:emma_mobile/domain/model/measurements/measurement.dart';
import 'package:emma_mobile/domain/model/measurements/measurement_type.dart';

abstract class MeasurementRepository {
  Future<Iterable<Measurement>> fetchMeasurementList();

  Future<Iterable<MeasurementType>> fetchMeasurementTypeList();

  Future<void> saveMeasure(
    String date,
    MeasurementType type,
    String title,
    String value,
  );
}
