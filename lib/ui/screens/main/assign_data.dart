import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/bloc/assign/assign_state.dart';
import 'package:emma_mobile/ui/components/assign_item.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/assignment/assignment_new.dart';
import 'package:emma_mobile/ui/screens/assignment/calendar_screen.dart';
import 'package:emma_mobile/ui/screens/main/empty_block.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AssignBloc>();
    return BlocBuilder<AssignBloc, AssignState>(
      builder: (_, __) {
        if (bloc.assignment.isEmpty) {
          return _EmptyAssign();
        }
        final tasks = bloc.getTaskInDay(date: DateTime.now());
        final notCompletedTasks =
            tasks.where((e) => !e.completed && e.enable).toList();
        return Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Column(
            children: [
              if (tasks.isNotEmpty) ...[
                if (notCompletedTasks.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: notCompletedTasks.length > 2
                          ? 2
                          : notCompletedTasks.length,
                      itemBuilder: (_, i) {
                        return AssignItem(task: notCompletedTasks[i]);
                      },
                      separatorBuilder: (_, __) {
                        return Padding(padding: EdgeInsets.only(top: 8.h));
                      },
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: DefaultContainer(
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.h, bottom: 12.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: AppIcons.complete(),
                            ),
                            SizedBox(
                              width: 256.w,
                              child: Text(
                                'noPrescriptionsPlanTodayIntakesTitle'.tr,
                                style: AppTypography.font12.copyWith(
                                  color: AppColors.c9B9B9B,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ],
              DefaultContainer(
                minHeight: 125.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (tasks.isEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width),
                          Padding(
                            padding: EdgeInsets.only(top: 32.h, bottom: 12.h),
                            child: AppIcons.prescriptionsActive(),
                          ),
                          SizedBox(
                            width: 256.w,
                            child: Text(
                              'noPrescriptionsPlanTodayTitle'.tr,
                              style: AppTypography.font12.copyWith(
                                color: AppColors.c9B9B9B,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 24.h),
                          )
                        ],
                      )
                    else
                      _ProgressBar(
                        currentComplete: tasks.where((e) => e.completed).length,
                        maxCount: tasks.length,
                      ),
                    ColoredBox(
                      color: AppColors.cEBEEF3,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 1.h,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CalendarScreen(),
                          ),
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        height: 50.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              AppIcons.calendar(),
                              Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Text(
                                  'История назначений',
                                  style: AppTypography.font12.copyWith(
                                    color: AppColors.c3B4047,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              AppIcons.arrowRight(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _EmptyAssign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
          child: EmptyBlockMain(
            icon: AppIcons.prescriptionsInactive(),
            title: 'Здесь будут показываться ваши\nближайшие назначения',
            buttonTitle: 'addNewPrescriptionLabel'.tr,
            onTap: () {
              navigatorPush(context, AssignmentNewScreen());
            },
          ),
        ),
        DefaultContainer(
          minHeight: 98.h,
          child: Center(
            child: SizedBox(
              width: 224.w,
              child: Text(
                'titleInfoProgressPrescriptions'.tr,
                style: AppTypography.font12.copyWith(
                  color: AppColors.c9B9B9B,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final int maxCount;
  final int currentComplete;

  const _ProgressBar({
    Key key,
    this.maxCount,
    this.currentComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = 264.w * currentComplete / maxCount;
    String text = 'titlePerformedPrescriptions'.tr;
    text = text.replaceAll(RegExp('#COUNT#'), currentComplete.toString());
    text = text.replaceAll(RegExp('#SUM#'), maxCount.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.h, left: 12.w),
          child: Text(
            text,
            style: AppTypography.font14.copyWith(
              color: AppColors.c3B4047,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 12.h,
            bottom: 18.h,
            left: 12.w,
            right: 12.w,
          ),
          child: Container(
            height: 10.h,
            width: 264.w,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: AppColors.cECEFFB,
            ),
            clipBehavior: Clip.antiAlias,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                width: width.isInfinite ? 0 : width,
                height: 10.h,
                duration: Constants.buttonDuration,
                curve: Curves.linear,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: AppColors.c00ACE3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
