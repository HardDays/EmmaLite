import 'package:emma_mobile/models/app_settings/app_settings.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';

class AppLocalRepository {
  final _hiveBoxes = HiveBoxes();

  static const _key = 'settings';

  AppSettings getSettings() {
    if ( _hiveBoxes.appSettingsBox.get(_key) == null) {
      _hiveBoxes.appSettingsBox.put(_key, AppSettings());
    }
    return _hiveBoxes.appSettingsBox.get(_key);
  }

  void putSettings(AppSettings settings) {
    _hiveBoxes.appSettingsBox.put(_key, settings);
  }

}
