import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text,
    {Duration duration = const Duration(seconds: 2)}) {
  final flushBar = Flushbar(
    margin: const EdgeInsets.only(left: 100, right: 100, bottom: 24),
    padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 7),
    borderRadius: 25,
    messageText: Text(
      text,
      style:
          CustomTextStyles.introLogoSubtitle.copyWith(color: AppColors.cFFFFFF),
    ),
    backgroundColor: AppColors.cCC000000,
    duration: duration,
  );
  flushBar.show(context);
}
