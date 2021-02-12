import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/settings/settings_item.dart';
import 'package:emma_mobile/ui/screens/settings/about_text_screen.dart';
import 'package:emma_mobile/ui/screens/settings/feedback_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  final Function onTap;

  const AboutAppScreen({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmmaAppBar(
          title: 'titleAboutApp'.tr,
          leading: BackLeading(
            text: 'mainSettingsTitle'.tr,
            onTap: onTap,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: SettingsItem(
            title: 'titleFeedback'.tr,
            icon: AppIcons.message(),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => FeedbackScreen()),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: SettingsItem(
            title: 'subscriptionConditions'.tr,
            icon: AppIcons.documents(),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AboutTextScreen(
                    title: 'subscriptionConditions'.tr,
                    filePath: Get.locale.languageCode == 'ru'
                        ? 'assets/documents/terms_and_conditions_ru.pdf'
                        : 'assets/documents/terms_and_conditions_en.pdf',
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: SettingsItem(
            title: 'subscriptionConfidentiality'.tr,
            icon: AppIcons.privacy(),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AboutTextScreen(
                    title: 'subscriptionConfidentiality'.tr,
                    filePath: Get.locale.languageCode == 'ru'
                        ? 'assets/documents/privacy_policy_ru.pdf'
                        : 'assets/documents/privacy_policy_en.pdf',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
