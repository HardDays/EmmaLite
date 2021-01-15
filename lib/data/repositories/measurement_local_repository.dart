import 'package:emma_mobile/data/service/error_mapper.dart';
import 'package:emma_mobile/domain/model/measurements/measurement.dart';
import 'package:emma_mobile/domain/model/measurements/measurement_type.dart';
import 'package:emma_mobile/domain/repositories/measurement_repository.dart';
import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MeasurementRepository)
class MeasurementLocalRepository implements MeasurementRepository {
  @override
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

  @override
  Future<Iterable<MeasurementType>> fetchMeasurementTypeList() async {
    final measurumentsTypes = <MeasurementType>[
      MeasurementType(0, 'Пульс', 'уд/мин'),
      MeasurementType(1, 'Артериальное давление', 'мм.рт.ст'),
      MeasurementType(2, 'Вес', 'кг'),
      MeasurementType(3, 'Сахар в крови', 'ммоль/л'),
      MeasurementType(4, 'Температура', '°C'),
    ];
    return measurumentsTypes;
  }

  @override
  Future<void> saveMeasure(
      String date, MeasurementType type, String title, String value) async {
    try {
      final box = await Hive.openBox<Measurement>('measurements');
      final measurement = Measurement(
        id: box.values.isNotEmpty ? box.values.last.id + 1 : 0,
        assetName: Assets.icons.measurementDefault.path,
        date: date,
        measureType: type.unitsName,
        title: title,
        value: value,
      );
      box.add(measurement);
    } catch (error) {
      throw mapToErrorModel(error);
    }
  }
}
