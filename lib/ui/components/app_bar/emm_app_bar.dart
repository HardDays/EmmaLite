import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmmaAppBar extends StatelessWidget {
  final String title;
  final Widget leading;
  final Widget trailing;
  final Widget childUpperLine;

  const EmmaAppBar({
    Key key,
    this.title,
    this.leading,
    this.trailing,
    this.childUpperLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.cFFFFFF,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 100.h,
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      if (leading != null) leading,
                      const Spacer(),
                      if (trailing != null) trailing,
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h, left: 16.w),
                  child: Text(
                    title,
                    style: AppTypography.font22.copyWith(
                      color: AppColors.c3B4047,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (childUpperLine != null) childUpperLine,
          ColoredBox(
            color: AppColors.cE6E9EB,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 1.h,
            ),
          )
        ],
      ),
    );
  }
}

class BackLeading extends StatelessWidget {
  final String text;
  final Function onTap;

  const BackLeading({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap == null) {
          Navigator.of(context).pop();
        } else {
          onTap.call();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(
          top: 11.h,
          bottom: 13.h,
          left: 11.w,
          right: 8.w,
        ),
        child: Row(
          children: [
            AppIcons.chevronLeft(),
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Text(
                text,
                style: AppTypography.font14.copyWith(
                  color: AppColors.c00ACE3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
