import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmptyBlockMain extends StatelessWidget {
  const EmptyBlockMain({
    Key key,
    this.title = '',
    this.buttonTitle = '',
    this.onTap,
    this.icon,
    this.shadows,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final String buttonTitle;
  final Widget icon;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 32.h,
        bottom: 24.h,
        left: 16.w,
        right: 16.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        boxShadow: shadows ??
            [
              const BoxShadow(
                offset: Offset(0, 2),
                spreadRadius: 0,
                blurRadius: 4,
                color: AppColors.c0D000000,
              )
            ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          icon,
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
            child: Text(
              title,
              style: AppTypography.font12.copyWith(color: AppColors.c9B9B9B),
              textAlign: TextAlign.center,
            ),
          ),
          EmmaFilledButton(
            title: buttonTitle,
            onTap: onTap?.call,
            fontSize: Constants.textSize14,
          )
        ],
      ),
    );
  }
}
