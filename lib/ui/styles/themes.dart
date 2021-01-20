import 'package:emma_mobile/generated/fonts.gen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData mainThemeData = ThemeData(
  fontFamily: FontFamily.sFProDisplay,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.cF5F7FA,
  appBarTheme: const AppBarTheme(color: AppColors.cFFFFFF),
  cupertinoOverrideTheme: const CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      dateTimePickerTextStyle: TextStyle(
        fontSize: 20,
        color: AppColors.c4A4A4A,
      ),
    )
  ),
  primaryColor: AppColors.c3B4047,
);
