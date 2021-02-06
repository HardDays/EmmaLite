
import 'package:emma_mobile/bloc/app_settings/app_settings_state.dart';
import 'package:emma_mobile/models/app_settings/app_settings.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void setShowProfilePlusHelp() {
    _appSettings.showProfilePlusHelp = true;
    emit(AppSettingsState());
  }

}