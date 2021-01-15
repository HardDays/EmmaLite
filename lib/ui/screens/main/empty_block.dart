import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
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
      padding: const EdgeInsets.only(top: 32, bottom: 24, left: 16, right: 16),
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
          const HSpace(12),
          Text(
            title,
            style: CustomTextStyles.introLogoSubtitle
                .copyWith(fontSize: 12, color: AppColors.c9B9B9B),
          ),
          const HSpace(16),
          EmmaFilledButton(title: buttonTitle, onTap: onTap?.call)
        ],
      ),
    );
  }
}
