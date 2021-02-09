import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/settings/settings_item.dart';
import 'package:emma_mobile/ui/screens/settings/confidential_screen.dart';
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SettingsItem(
                    title: 'Язык',
                    icon: AppIcons.language(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SettingsItem(
                    title: 'Синхронизация',
                    icon: AppIcons.health(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SettingsItem(
                    title: 'О приложении',
                    icon: AppIcons.privacyDocs(),
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
