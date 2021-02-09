import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/settings/settings_item.dart';
import 'package:emma_mobile/ui/screens/settings/about_app_screen.dart';
import 'package:emma_mobile/ui/screens/settings/confidential_screen.dart';
import 'package:emma_mobile/ui/screens/settings/language_screen.dart';
import 'package:emma_mobile/ui/screens/settings/sync_screen.dart';
import 'package:emma_mobile/ui/screens/settings/theme_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function(Widget screen) onChange;

  const SettingsScreen({Key key, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EmmaAppBar(title: 'Настройки'),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SettingsItem(
                  title: 'Конфиденциальность',
                  onTap: () => onChange(
                    ConfidentialScreen(
                      onTap: () => onChange(SettingsScreen(onChange: onChange)),
                    ),
                  ),
                  icon: AppIcons.privacy(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SettingsItem(
                    title: 'Память',
                    icon: AppIcons.privacy(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SettingsItem(
                    title: 'Оформление',
                    subtitle: 'Светлая тема',
                    icon: AppIcons.design(),
                    onTap: () => onChange(
                      ThemeScreen(
                        onTap: () => onChange(
                          SettingsScreen(onChange: onChange),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SettingsItem(
                    title: 'Язык',
                    onTap: () => onChange(
                      LanguageScreen(
                        onTap: () => onChange(
                          SettingsScreen(onChange: onChange),
                        ),
                      ),
                    ),
                    icon: AppIcons.language(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SettingsItem(
                    title: 'Синхронизация',
                    onTap: () => onChange(
                      SettingsSyncScreen(
                        onTap: () => onChange(
                          SettingsScreen(onChange: onChange),
                        ),
                      ),
                    ),
                    icon: AppIcons.health(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SettingsItem(
                    title: 'О приложении',
                    icon: AppIcons.privacyDocs(),
                    onTap: () => onChange(
                      AboutAppScreen(
                        onTap: () => onChange(
                          SettingsScreen(onChange: onChange),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 54.h),
      ],
    );
  }
}
