import 'dart:math';

import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class ProfileHelpWidget extends StatelessWidget {
  final String text;
  final Function closeTap;

  const ProfileHelpWidget({Key key, this.text, this.closeTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.cA0B4CB,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 80.h,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppIcons.info(),
            ),
            Expanded(
              child: Text(
                text,
                style: AppTypography.font12.copyWith(
                  color: AppColors.cFFFFFF,
                ),
              ),
            ),
            GestureDetector(
              onTap: closeTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                  vertical: 5.h,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Transform.rotate(
                    angle: pi / 4,
                    child: AppIcons.plus(color: AppColors.cFFFDFD),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
