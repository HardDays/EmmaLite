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

  AppSettings({
    this.currentProfileIndex = 0,
    this.isFirstRun = true,
    this.showProfilePlusHelp = false,
    this.showProfileCreateHelp = false,
  }) {
    isFirstRun ??= true;
    showProfilePlusHelp ??= false;
    showProfileCreateHelp ??= false;
  }
}
