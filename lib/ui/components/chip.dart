import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class ChipItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function onTap;

  const ChipItem({
    Key key,
    this.title,
    this.isActive,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(right: 4.w),
          height: 32.h,
          decoration: BoxDecoration(
            color: isActive ? AppColors.c00ACE3 : AppColors.cFFFFFF,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(width: 1.w, color: AppColors.c00ACE3),
          ),
          child: Center(
            child: Text(
              title,
              style: AppTypography.font12.copyWith(
                fontWeight: FontWeight.w500,
                color: !isActive ? AppColors.c00ACE3 : AppColors.cFFFFFF,
              ),
            ),
          ),
        ),
      ),
    );
  }
}