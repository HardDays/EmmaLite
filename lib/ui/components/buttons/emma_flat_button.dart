import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmmaFlatButton extends StatelessWidget {
  const EmmaFlatButton({this.title = '', this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap?.call,
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      focusColor: AppColors.transparent,
      child: Text(title, style: CustomTextStyles.flatButtonTitle),
    );
  }
}
