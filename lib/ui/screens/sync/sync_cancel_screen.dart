import 'dart:io';

import 'package:emma_mobile/ui/screens/navigator_screen.dart';
import 'package:emma_mobile/ui/screens/sync/sync_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SyncCancelScreen extends StatelessWidget {
  SyncCancelScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SyncScreen(
      text: Platform.isAndroid
          ? 'Вы всегда можете перейти к Google fit позже в разделе настроек «Партнёрские приложения».'
          : 'Вы всегда можете перейти к Apple Здоровье позже в разделе настроек «Партнёрские приложения».',
      buttonTitle: 'doneAppleHealthButtonTitle'.tr,
      onNext: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => NavigatorScreen()));
      },
    );
  }
}
