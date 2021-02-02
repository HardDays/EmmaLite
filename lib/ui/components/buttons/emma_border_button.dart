import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmmaBorderButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const EmmaBorderButton({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 288.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(32)),
          border: Border.all(
            color: AppColors.c00ACE3,
            width: 1.w,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTypography.font18.copyWith(
              color: AppColors.c00ACE3,
            ),
          ),
        ),
      ),
    );
  }
}
