import 'package:hive/hive.dart';

class MainLocalRepository {
  @override
  Iterable<int> fetchMeasurementList() {
    // final types =
    //     await locator.get<MeasurementRepository>().fetchMeasurementTypeList();
    // final measurements = <Measurement>[];
    // final box = await Hive.openBox<Measurement>('measurements');

    // for (var i in types) {
    //   measurements.add(
    //     box.values.lastWhere((element) => element.title == i.name,
    //         orElse: () => null),
    //   );
    // }
    return [];
    // return Future.value(measurements.where((element) => element != null));
  }
}
