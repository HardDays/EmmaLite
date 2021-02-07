import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 8)
class AppSettings extends HiveObject {
  @HiveField(0)
  int currentProfileIndex;
  @HiveField(1)
  bool isFirstRun;
  @HiveField(2)
  bool showProfilePlusHelp;
  @HiveField(3)
  bool showProfileCreateHelp;
  @HiveField(4)
  bool showProfileSettingsHelp;

  AppSettings({
    this.currentProfileIndex = 0,
    this.isFirstRun = true,
    this.showProfilePlusHelp = false,
    this.showProfileCreateHelp = false,
    this.showProfileSettingsHelp,
  }) {
    isFirstRun ??= true;
    showProfilePlusHelp ??= false;
    showProfileCreateHelp ??= false;
    showProfileSettingsHelp ??= false;
  }
}
