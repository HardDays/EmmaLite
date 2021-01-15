import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmmaAppBarWithBottom extends StatelessWidget with PreferredSizeWidget {
  const EmmaAppBarWithBottom({
    @required this.titleText,
    this.centerTitle,
    this.leading,
    this.bottomWidget,
  });

  final Widget leading;
  final String titleText;
  final bool centerTitle;
  final Widget bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.cFFFFFF,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(titleText, style: CustomTextStyles.expandedAppBarTitle),
            bottomWidget
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(200);
}
