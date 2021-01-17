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
      child: Text(
        title,
        style: AppTypography.font14.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.c00ACE3,
        ),
      ),
    );
  }
}
