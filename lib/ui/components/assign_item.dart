import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';
import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class AssignItem extends StatelessWidget {
  final RunTask task;

  const AssignItem({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isExpired = task.dateTime.isBefore(DateTime.now());
    final assign = context.bloc<AssignBloc>().getAssignById(task.assignId);
    return Center(
      child: DefaultContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 12.w,
                  right: 16.w,
                  top: 8.h,
                  bottom: 8.h,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      task.type.iconPath,
                      width: 44.w,
                      height: 44.h,
                      fit: BoxFit.contain,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 9.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Text(
                                task.assignName,
                                style: AppTypography.font14.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.c3B4047,
                                ),
                              ),
                            ),
                            if (assign.type is MedicineAssignType)
                              Text(
                                '${assign.dosage} x ${task.count}',
                                style: AppTypography.font14.copyWith(
                                  color: AppColors.c8E8E93,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (!task.completed)
                      GestureDetector(
                        onTap: () =>
                            context.bloc<AssignBloc>().completeTask(task),
                        child: SizedBox(
                          width: 52.w,
                          height: 32.h,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.cD1D1D6, width: 1.w),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: AppIcons.accept(
                                width: 20.w,
                                height: 14.h,
                                color: AppColors.cD1D1D6,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1.h,
              color: AppColors.cE6E9EB,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 32.h,
              color: isExpired
                  ? AppColors.cFF3B30.withOpacity(0.1)
                  : AppColors.cFFFFFF,
              child: Center(
                child: Text(
                  '${DateFormat.Hm().format(task.dateTime)} (${task.mainText(
                    isExpired: isExpired,
                    completeDate: task.completedDate,
                  )})',
                  style: AppTypography.font12.copyWith(
                    color: isExpired ? AppColors.cFF3B30 : AppColors.c9B9B9B,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
