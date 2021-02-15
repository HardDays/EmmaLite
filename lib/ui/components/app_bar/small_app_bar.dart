import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class SmallAppBar extends StatelessWidget {
  final Widget leading;
  final String leadingText;
  final Widget trailing;
  final String title;
  final Function leadingTap;

  const SmallAppBar({
    Key key,
    this.leading,
    this.leadingText,
    this.trailing,
    this.title,
    this.leadingTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.cFFFFFF,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 44.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (leading != null || leadingText != null) ...[
                Positioned(
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      if (leadingTap == null) {
                        Navigator.of(context).pop();
                      } else {
                        leadingTap.call();
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: leading ??
                            Text(
                              leadingText,
                              style: AppTypography.font12.copyWith(
                                color: AppColors.c00ACE3,
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
              ],
              Text(
                title,
                style: AppTypography.font16.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.c4A4A4A,
                ),
              ),
              if (trailing != null)
                Positioned(
                  right: 0,
                  child: trailing,
                )
            ],
          ),
        ),
      ),
    );
  }
}
