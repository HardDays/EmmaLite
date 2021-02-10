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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 167.w,
                  child: Text(
                    title,
                    style: AppTypography.font16.copyWith(
                      color: AppColors.c3B4047,
                    ),
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: AppTypography.font12.copyWith(
                      color: AppColors.c9B9B9B,
                    ),
                  )
              ],
            ),
            const Spacer(),
            if (subIcon != null)
              subIcon,
            AppIcons.arrowRight(),
          ],
        ),
      ),
    );
  }
}
