import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/sync/sync_state.dart';
import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:emma_mobile/repositories/measurement_local_repository.dart';
import 'package:health/health.dart';

class SyncCubit extends Cubit<SyncState> {
  final _health = HealthFactory();
  final _repository = MeasurementLocalRepository();
  final _appLocalRepository = AppLocalRepository();

  SyncCubit() : super(SyncState());

  Future _importPressure() async {
    try {
      final data1 = await _health.getHealthDataFromTypes(
          DateTime.now().subtract(Duration(days: 365)), DateTime.now(), [
        HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      ]);
      data1.sort((d1, d2) => d1.dateFrom.compareTo(d2.dateFrom));

      final data2 = await _health.getHealthDataFromTypes(
          DateTime.now().subtract(Duration(days: 365)), DateTime.now(), [
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      ]);
      data2.sort((d1, d2) => d1.dateFrom.compareTo(d2.dateFrom));

      for (int i = 0; i < data1.length; i++) {
        final id = data1[i].dateFrom.millisecondsSinceEpoch;
        if (!_repository.hasPressure(id)) {
          _repository.saveArterialPressure(
              pressure: ArterialPressure(
            id: id,
            userId: _appLocalRepository.currentUserId,
            top: data1[i].value.toInt(),
            under: data2[i].value.toInt(),
            date: data1[i].dateFrom.toString(),
          ));
        }
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future _importGlucose() async {
    try {
      final data = await _health.getHealthDataFromTypes(
          DateTime.now().subtract(Duration(days: 365)), DateTime.now(), [
        HealthDataType.BLOOD_GLUCOSE,
      ]);

      for (final value in data) {
        final id = value.dateFrom.millisecondsSinceEpoch;
        if (!_repository.hasBloodSugar(id)) {
          _repository.saveBloodSugar(
            bloodSugar: BloodSugar(
              id: id,
              userId: _appLocalRepository.currentUserId,
              date: value.dateFrom.toString(),
              sugar: value.value.toDouble(),
              eatTime: value.dateFrom.toString(),
            ),
          );
        }
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future _importWeight() async {
    try {
      final data = await _health.getHealthDataFromTypes(
          DateTime.now().subtract(Duration(days: 365)), DateTime.now(), [
        HealthDataType.WEIGHT,
      ]);
      for (final value in data) {
        final id = value.dateFrom.millisecondsSinceEpoch;
        if (!_repository.hasHeightModel(id)) {
          _repository.saveHeightModel(
            height: HeightModel(
              id: id,
              userId: _appLocalRepository.currentUserId,
              date: value.dateFrom.toString(),
              height: value.value.toDouble(),
            ),
          );
        }
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future _importTemperature() async {
    try {
      final data = await _health.getHealthDataFromTypes(
          DateTime.now().subtract(Duration(days: 365)), DateTime.now(), [
        HealthDataType.BODY_TEMPERATURE,
      ]);

      for (final value in data) {
        final id = value.dateFrom.millisecondsSinceEpoch;
        if (!_repository.hasTemperature(id)) {
          _repository.saveTemperature(
            temperature: Temperature(
              id: id,
              userId: _appLocalRepository.currentUserId,
              date: value.dateFrom.toString(),
              temperature: value.value.toDouble(),
            ),
          );
        }
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future _importHeartRate() async {
    try {
      final data = await _health.getHealthDataFromTypes(
        DateTime.now().subtract(Duration(days: 365)),
        DateTime.now(),
        [
          HealthDataType.HEART_RATE,
        ],
      );

      for (final value in data) {
        final id = value.dateFrom.millisecondsSinceEpoch;
        if (!_repository.hasPulse(id)) {
          _repository.savePulse(
            pulse: Pulse(
              id: id,
              userId: _appLocalRepository.currentUserId,
              date: value.dateFrom.toString(),
              pulse: value.value.toInt(),
              pulseType: 1,
            ),
          );
        }
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future init() async {
    final auth = await _health.requestAuthorization([
      HealthDataType.WEIGHT,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.HEART_RATE,
      HealthDataType.BODY_TEMPERATURE,
    ]);
    if (auth) {
      await _importPressure();
      await _importGlucose();
      await _importWeight();
      await _importTemperature();
      await _importHeartRate();
    }
  }
}
