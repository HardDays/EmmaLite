 import 'package:bot_toast/bot_toast.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

abstract class Toast {
  static void show(String text) {
    BotToast.showText(
      text: text,
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 8.h,
      ),
      contentColor: AppColors.c000000.withOpacity(0.8),
      textStyle: AppTypography.font14.copyWith(
        color: AppColors.cFFFFFF,
      ),
    );
  }
 }