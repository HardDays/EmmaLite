import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final Widget icon;
  final Widget subIcon;
  final String title;
  final String subtitle;
  final Function onTap;

  const SettingsItem({
    Key key,
    this.icon,
    this.title,
    this.onTap,
    this.subIcon,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      minHeight: 68.h,
      maxHeight: 68.h,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cF5F7FA,
                ),
                child: Center(child: icon),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 44.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: AppTypography.font16.copyWith(
                                  color: AppColors.c3B4047,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 2.h)),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                subtitle ?? '',
                                style: AppTypography.font12.copyWith(
                                  color: AppColors.c9B9B9B,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (subIcon != null) subIcon,
            AppIcons.arrowRight(),
          ],
        ),
      ),
    );
  }
}
