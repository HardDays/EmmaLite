import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class AssignmentTypeChip extends StatelessWidget {
  const AssignmentTypeChip({this.assignmentType, this.isActive});

  final String assignmentType;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(color: AppColors.c00ACE3),
      borderRadius: BorderRadius.circular(16),
      color: isActive ? AppColors.c00ACE3 : AppColors.transparent,
    );

    return Container(
      decoration: decoration,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(
        assignmentType,
        style: isActive
            ? CustomTextStyles.flatButtonTitle
            : CustomTextStyles.flatButtonTitle
                .copyWith(color: AppColors.cFFFFFF),
      ),
    );
  }
}
