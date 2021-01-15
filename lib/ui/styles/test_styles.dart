import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomTextStyles {

  static const Color defaultColor = AppColors.c3B4047;

  static const TextStyle splashScreen = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: defaultColor
  );

  static const TextStyle filledButtonTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.cFFFFFF
  );

  static const TextStyle flatButtonTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.c00ACE3
  );

  static const TextStyle textFieldText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: defaultColor
  );

  static const TextStyle keypadItem = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w300,
    color: defaultColor
  );

  //Intro logo
  static const TextStyle introLogoTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: defaultColor
  );

  static const TextStyle introLogoSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: defaultColor
  );

  //GenderPicker
  static const TextStyle activeGenderBlock = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.cFFFFFF
  );

  static const TextStyle inactiveGenderBlock = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.c9B9B9B
  );

  //AppBar
  static const TextStyle expandedAppBarTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: defaultColor
  );

  static const TextStyle generalAppBarTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: defaultColor
  );

  static const TextStyle textBackButton = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.c00ACE3,
  );

  //Measurement List Item
  static const TextStyle measurementDate = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: defaultColor
  );

  //Picker children style
  static const TextStyle pickerChildrenTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: defaultColor
  );
}