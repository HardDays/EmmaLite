import 'package:emma_mobile/data/serializers/serializers.dart';
import 'package:emma_mobile/di/service_locator.dart';
import 'package:emma_mobile/domain/common/async_field.dart';
import 'package:emma_mobile/domain/model/common/error_model.dart';
import 'package:emma_mobile/domain/repositories/app_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:local_auth/local_auth.dart';

import 'app_common_state.dart';

class AppCommon extends HydratedCubit<AppCommonState> {
  AppCommon(this.repository) : super(AppCommonState()) {
    locator.registerSingleton<AppCommon>(this);
  }

  final localAuth = LocalAuthentication();
  final AppRepository repository;

  void init() {
    _checkBiometry();
    _checkLaunchFirstTimeOrNot();
  }

  Future<void> _checkBiometry() async {
    final availableBiometrics = await localAuth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)) {
      emit(state.rebuild((s) => s.currentBiometricType = BiometricType.face));
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      emit(
        state
            .rebuild((s) => s.currentBiometricType = BiometricType.fingerprint),
      );
    }
  }

  void _checkLaunchFirstTimeOrNot() {
    emit(state.rebuild((s) => s.isLaunchFirstTime = true));
    if (state.isLaunchFirstTime == true) {
      //Заглушка
      Future.delayed(
        const Duration(seconds: 2),
        () => emit(state.rebuild((s) => s.isLaunchFirstTime = false)),
      );
    } else {
      emit(state.rebuild((s) => s.isLaunchFirstTime = false));
    }
  }

  void savePin(String pin) {
    if (pin.length == 4) {
      emit(state.rebuild((s) => s.pinCode = pin));
    }
  }

  void saveTemp(String pin) {
    emit(state
        .rebuild((s) => s.tempCode.replace(AsyncField<String>.inProgress())));
    if (pin.length == 4) {
      emit(state
          .rebuild((s) => s.tempCode.replace(AsyncField<String>.success(pin))));
    }
  }

  void checkTemp(String pin) {
    if (pin.length == 4 && pin != state.tempCode.payload) {
      emit(state.rebuild(
          (s) => s.tempCode.replace(AsyncField<String>.error(ErrorModel((s) {
                s.message = 'Пароли не совпадают';
              })))));
      //todo: Переделать этот момент, временное решение
      Future.delayed(
        const Duration(seconds: 1),
        () => emit(state.rebuild((s) => s.tempCode = null)),
      );
    }
    if (pin.length == 4 && pin == state.tempCode.payload) {
      savePin(pin);
    }
  }

  void checkPin(String pin) {
    if (pin.length == 4) {
      emit(state.rebuild((s) => s.isAuthorized = pin == s.pinCode));
    }
  }

  void completeRegistration() {
    emit(state.rebuild((s) {
      s.isRegistrationCompleted = true;
    }));
  }

  void logOut() {
    emit(state.rebuild((s) {
      s.isAuthorized = false;
    }));
  }

  void grantBiometry() {
    emit(state.rebuild((s) => s.biometryGranted = true));
  }

  @override
  AppCommonState fromJson(Map<String, dynamic> json) {
    return deserialize<AppCommonState>(json);
  }

  @override
  Map<String, dynamic> toJson(AppCommonState state) {
    return serializers.serializeWith(AppCommonState.serializer, state);
  }
}
