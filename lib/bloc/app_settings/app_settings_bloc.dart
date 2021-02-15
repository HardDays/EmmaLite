import 'package:emma_mobile/bloc/app_settings/app_settings_state.dart';
import 'package:emma_mobile/models/app_settings/app_settings.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppSettingsBloc extends Cubit<AppSettingsState> {
  AppSettingsBloc() : super(AppSettingsState()) {
    _init();
  }

  final _appLocalRepository = AppLocalRepository();

  AppSettings _appSettings;

  AppSettings get appSettings => _appSettings;

  void _init() {
    _appSettings = _appLocalRepository.getSettings();
  }

  void setLocale(String locale) {
    Get.updateLocale(Locale(locale));
    Intl.defaultLocale = locale;
    _appSettings.locale = locale;
    _updateSettings();
  }

  void setUseFaceId(bool v) {
    _appSettings.useFaceId = v;
    _updateSettings();
  }

  void setUsePassword(bool v) {
    _appSettings.usePassword = v;
    _updateSettings();
  }

  void setTheme(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    Get.changeTheme(
      Get.theme.copyWith(
        brightness:
            themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
      ),
    );
    _appSettings.lightTheme = themeMode == ThemeMode.light;
    Future.delayed(const Duration(milliseconds: 100), _updateSettings);
  }

  void setFirstRun() {
    _appSettings.isFirstRun = false;
    _updateSettings();
  }

  void setPasswordText(String password) {
    _appSettings.password = password;
    _updateSettings();
  }

  void setPassword(String password) {
    _appSettings.password = password;
    _appSettings.usePassword = true;
    _updateSettings();
  }

  void setShowProfilePlusHelp() {
    _appSettings.showProfilePlusHelp = true;
    _updateSettings();
  }

  void setShowProfileCreateHelp() {
    _appSettings.showProfileCreateHelp = true;
    _updateSettings();
  }

  void setShowProfileSettingsHelp() {
    _appSettings.showProfileSettingsHelp = true;
    _updateSettings();
  }

  void _updateSettings() {
    _appLocalRepository.putSettings(_appSettings);
    emit(AppSettingsState());
  }

  void update() {
    emit(AppSettingsState());
  }
}
