import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/measurement_type.dart';
import 'package:hive/hive.dart';

class MeasurementLocalRepository {
  Future<Iterable<Measurement>> fetchMeasurementList() async {
    final types = await fetchMeasurementTypeList();
    final measurements = <Measurement>[];
    final box = await Hive.openBox<Measurement>('measurements');
    for (var i in types) {
      measurements.add(
        box.values.lastWhere(
          (element) => element.title == i.name,
          orElse: () => null,
        ),
      );
    }
    return Future.value(measurements.where((element) => element != null));
  }

  Future<Iterable<MeasurementType>> fetchMeasurementTypeList() async {
    final measurementsTypes = <MeasurementType>[
      MeasurementType(0, 'Пульс', 'уд/мин'),
      MeasurementType(1, 'Артериальное давление', 'мм.рт.ст'),
      MeasurementType(2, 'Вес', 'кг'),
      MeasurementType(3, 'Сахар в крови', 'ммоль/л'),
      MeasurementType(4, 'Температура', '°C'),
    ];
    return measurementsTypes;
  }

  Future<void> saveMeasure(
      String date, MeasurementType type, String title, String value) async {
    final box = await Hive.openBox<Measurement>('measurements');
    final measurement = Measurement(
      box.values.isNotEmpty ? box.values.last.id + 1 : 0,
      Assets.icons.measurementDefault.path,
      date,
      type.unitsName,
      title,
      value,
    );
    box.add(measurement);
  }
}
