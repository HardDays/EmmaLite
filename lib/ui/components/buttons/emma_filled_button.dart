import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmmaFilledButton extends StatelessWidget {
  const EmmaFilledButton(
      {Key key,
      this.title = '',
      this.onTap,
      this.width = double.infinity,
      this.height = 50,
      this.isActive = true,
      this.activeColor = AppColors.c00ACE3,
      this.inactiveColor = AppColors.cCED3DB,
      this.borderRadius = 32})
      : super(key: key);

  final double width;
  final double height;
  final double borderRadius;
  final Color activeColor;
  final Color inactiveColor;
  final bool isActive;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
        onPressed: isActive ? onTap?.call : null,
        color: isActive ? activeColor : inactiveColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(title, style: CustomTextStyles.filledButtonTitle),
        ),
      ),
    );
  }
}
