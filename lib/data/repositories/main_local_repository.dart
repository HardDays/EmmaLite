import 'package:emma_mobile/di/service_locator.dart';
import 'package:emma_mobile/domain/model/measurements/measurement.dart';
import 'package:emma_mobile/domain/repositories/main_repository.dart';
import 'package:emma_mobile/domain/repositories/measurement_repository.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MainRepository)
class MainLocalRepository implements MainRepository {
  @override
  Future<Iterable<Measurement>> fetchMeasurementList() async {
    final types =
        await locator.get<MeasurementRepository>().fetchMeasurementTypeList();
    final measurements = <Measurement>[];
    final box = await Hive.openBox<Measurement>('measurements');

    for (var i in types) {
      measurements.add(
        box.values.lastWhere((element) => element.title == i.name,
            orElse: () => null),
      );
    }
    return Future.value(measurements.where((element) => element != null));
  }
}
