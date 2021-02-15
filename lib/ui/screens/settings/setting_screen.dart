import 'package:emma_mobile/models/language.dart';
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
        EmmaAppBar(title: 'mainSettingsTitle'.tr),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SettingsItem(
                  title: 'titleSettingsAddPassword'.tr,
                  onTap: () => onChange(
                    ConfidentialScreen(
                      onTap: () => onChange(SettingsScreen(onChange: onChange)),
                    ),
                  ),
                  icon: AppIcons.privacy(),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 8.h),
                //   child: SettingsItem(
                //     title: 'Память',
                //     icon: AppIcons.memory(),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SettingsItem(
                    title: 'themeCellTitle'.tr,
                    subtitle: Get.isDarkMode ? 'darkTheme'.tr : 'whiteTheme'.tr,
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
                    title: 'titleSettingLanguage'.tr,
                    onTap: () => onChange(
                      LanguageScreen(
                        onTap: () => onChange(
                          SettingsScreen(onChange: onChange),
                        ),
                      ),
                    ),
                    subtitle: languages
                        .firstWhere((e) => e.locale == Get.locale.languageCode)
                        .localizedTitle,
                    subIcon: Padding(
                      padding: EdgeInsets.only(right: 11.w),
                      child: AppIcons.languageFlag(
                        path: languages
                            .firstWhere(
                                (e) => e.locale == Get.locale.languageCode)
                            .iconPath,
                      ),
                    ),
                    icon: AppIcons.language(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SettingsItem(
                    title: 'synchronization'.tr,
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
                    title: 'titleAboutApp'.tr,
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
