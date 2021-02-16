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
      text: 'laterSync'.tr.replaceAll(RegExp('#APP#'),
          Platform.isAndroid ? 'Google Fit' : 'Apple Health app'),
      buttonTitle: 'doneAppleHealthButtonTitle'.tr,
      onNext: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => NavigatorScreen()));
      },
    );
  }
}
