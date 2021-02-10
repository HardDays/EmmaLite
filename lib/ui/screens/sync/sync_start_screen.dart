import 'dart:io';

import 'package:emma_mobile/ui/screens/sync/sync_info_screen.dart';
import 'package:emma_mobile/ui/screens/sync/sync_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SyncStartScreen extends StatelessWidget {
  const SyncStartScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SyncScreen(
      title: Platform.isAndroid
          ? 'Активируйте Google fit'
          : 'Активируйте Apple Health',
      text: 'activateAppleHealthSubTitle'.tr,
      buttonTitle: 'activateAppleHealthButtonTitle'.tr,
      hasBack: false,
      hasCancel: true,
      onNext: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SyncInfoScreen(),
          ),
        );
      },
    );
  }
}
