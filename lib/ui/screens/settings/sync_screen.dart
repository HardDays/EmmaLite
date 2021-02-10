import 'dart:io';

import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/settings/settings_item.dart';
import 'package:emma_mobile/ui/screens/sync/sync_info_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsSyncScreen extends StatelessWidget {
  final Function() onTap;

  const SettingsSyncScreen({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmmaAppBar(
          title: 'Синхронизация',
          leading: BackLeading(
            text: 'mainSettingsTitle'.tr,
            onTap: onTap,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 14.h),
          child: SettingsItem(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SyncInfoScreen(),
                ),
              );
            },
            title: Platform.isAndroid ? 'Google fit' : 'Health Kit',
            icon: SvgPicture.asset(
              Platform.isAndroid
                  ? 'assets/icons/google.svg'
                  : 'assets/icons/apple.svg',
              width: 44.w,
              height: 44.w,
            ),
          ),
        )
      ],
    );
  }
}
