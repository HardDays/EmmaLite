import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class PassPoints extends StatelessWidget {
  final int activeCount;
  final String text;
  final Color errorColor;
  final String errorText;
  final bool haveError;

  const PassPoints({
    Key key,
    this.activeCount = 0,
    this.text,
    this.errorColor,
    this.haveError = false,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h + 15.w,
      child: Column(
        children: [
          SizedBox(
            width: 220.w,
            child: Text(
              haveError ? errorText : text,
              style: AppTypography.font16.copyWith(
                color: haveError ? errorColor : AppColors.c3B4047,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _PasswordItem(
                    isActive: activeCount > 0,
                    color: haveError ? errorColor : null,
                  ),
                  _PasswordItem(
                    isActive: activeCount > 1,
                    color: haveError ? errorColor : null,
                  ),
                  _PasswordItem(
                    isActive: activeCount > 2,
                    color: haveError ? errorColor : null,
                  ),
                  _PasswordItem(
                    isActive: activeCount > 3,
                    color: haveError ? errorColor : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordItem extends StatelessWidget {
  final bool isActive;
  final Color color;

  const _PasswordItem({
    Key key,
    this.isActive = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15.w,
      height: 15.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.c00ACE3 : Colors.transparent,
        border: Border.all(
          color: isActive ? AppColors.c00ACE3 : color ?? AppColors.cA0B4CB,
          width: 1.w,
        ),
      ),
    );
  }
}
