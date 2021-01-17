import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import 'app_common_state.dart';

class AppCommon extends Cubit<AppCommonState> {
  AppCommon(this.repository) : super(LoadingAppCommonState()) {
    init();
  }

  final localAuth = LocalAuthentication();
  final AppLocalRepository repository;

  BiometricType _biometricType;

  BiometricType get currentBiometricType => _biometricType;

  String _phone;

  String get phone => _phone;

  String _token;

  String get token => _token;

  bool _isLaunchFirstTime;

  bool get isLaunchFirstTime => _isLaunchFirstTime;

  bool get isRegistrationCompleted => true;

  String _pinCode;

  String get pinCode => _pinCode;

  bool _biometryGranted;

  bool get biometryGranted => _biometryGranted;

  User _user;

  User get user => _user;

  Future<void> init() async {
    await _checkBiometry();
    _checkLaunchFirstTimeOrNot();
  }

  Future<void> _checkBiometry() async {
    final availableBiometrics = await localAuth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)) {
      _biometricType = BiometricType.face;
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      _biometricType = BiometricType.fingerprint;
    }
  }

  void _checkLaunchFirstTimeOrNot() {
    _isLaunchFirstTime = true;
  }

  void savePin(String pin) {
    if (pin.length == 4) {
      _pinCode = pin;
    }
  }

  void saveTemp(String pin) {}

  void checkTemp(String pin) {}

  void checkPin(String pin) {}

  void completeRegistration() {}

  void logOut() {}

  void grantBiometry() {
    _biometryGranted = true;
  }
}
