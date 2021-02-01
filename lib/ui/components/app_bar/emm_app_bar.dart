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
