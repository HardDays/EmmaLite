import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';

Future showCupertinoWith2Button(
    BuildContext context, {
      String title,
      @required String subtitle,
      @required String leftText,
      @required String rightText,
      Function(BuildContext context) leftTap,
      Function(BuildContext context) rightTap,
    }) {
  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: title == null
            ? null
            : Text(
          title,
          style: AppTypography.font17.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          subtitle,
          style: AppTypography.font17.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => leftTap?.call(context),
            child: Text(
              leftText,
              style: AppTypography.font17.copyWith(
                color: AppColors.c4A4A4A,
              ),
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => rightTap?.call(context),
            child: Text(
              rightText,
              style: AppTypography.font17.copyWith(
                color: AppColors.c4A4A4A,
              ),
            ),
          ),
        ],
      );
    },
  );
}