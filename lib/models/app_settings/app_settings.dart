import 'dart:ui' as ui;

import 'package:emma_mobile/models/language.dart';
import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 8)
class AppSettings extends HiveObject {
  @HiveField(0)
  int currentProfileId;
  @HiveField(1)
  bool isFirstRun;
  @HiveField(2)
  bool showProfilePlusHelp;
  @HiveField(3)
  bool showProfileCreateHelp;
  @HiveField(4)
  bool showProfileSettingsHelp;
  @HiveField(5)
  String password;
  @HiveField(6)
  bool usePassword;
  @HiveField(7)
  bool useFaceId;
  @HiveField(8)
  String locale;
  @HiveField(9)
  bool lightTheme;

  AppSettings({
    this.currentProfileId,
    this.isFirstRun,
    this.showProfilePlusHelp,
    this.showProfileCreateHelp,
    this.showProfileSettingsHelp,
    this.password,
    this.useFaceId,
    this.usePassword,
    this.locale,
    this.lightTheme,
  }) {
    isFirstRun ??= true;
    showProfilePlusHelp ??= false;
    showProfileCreateHelp ??= false;
    showProfileSettingsHelp ??= false;
    useFaceId ??= false;
    lightTheme ??= true;
    if (locale == null) {
      final windowLocale = ui.window.locale.languageCode;
      if (languages.map((e) => e.locale).contains(windowLocale)) {
        locale = windowLocale;
      } else {
        locale = 'en';
      }
    }
  }
}
