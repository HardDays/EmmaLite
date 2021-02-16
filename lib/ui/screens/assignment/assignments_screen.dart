import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/bloc/assign/assign_state.dart';
import 'package:emma_mobile/bloc/assign_screen/assign_screen_bloc.dart';
import 'package:emma_mobile/bloc/assign_screen/assign_screen_state.dart';
import 'package:emma_mobile/models/assignment/assignment.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/assign/empty_or_expired.dart';
import 'package:emma_mobile/ui/components/assign_item.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/chip.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/profile/image.dart';
import 'package:emma_mobile/ui/screens/assignment/assignment_new.dart';
import 'package:emma_mobile/ui/screens/assignment/calendar_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AssignmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AssignBloc>();
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body: BlocProvider(
        create: (_) => AssignScreenBloc(),
        child: BlocBuilder<AssignBloc, AssignState>(
          builder: (context, __) {
            return BlocBuilder<AssignScreenBloc, AssignScreenState>(
              builder: (_, state) {
                return Column(
                  children: [
                    EmmaAppBar(
                      title: 'prescriptionsTitleLabel'.tr,
                      childUpperLine:
                          bloc.assignment.isNotEmpty ? _AppBar() : null,
                      trailing: bloc.assignment.isNotEmpty
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => CalendarScreen(),
                                      ),
                                    );
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 8.h,
                                      right: 8.w,
                                      left: 16.w,
                                    ),
                                    child: AppIcons.calendarActive(),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              AssignmentNewScreen()),
                                    );
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 8.h,
                                      right: 16.w,
                                      left: 8.w,
                                    ),
                                    child: AppIcons.plus(),
                                  ),
                                ),
                                ProfileTrailing(),
                              ],
                            )
                          : ProfileTrailing(),
                    ),
                    Expanded(
                      child: _Data(),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AssignScreenBloc>();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 3.h,
            left: 16.w,
            right: 16.w,
            bottom: bloc.state is HistoryAssignScreenState ? 12.h : 0,
          ),
          child: Row(
            children: [
              ChipItem(
                isActive: bloc.state is DoingAssignScreenState,
                title: 'toDo'.tr,
                onTap: bloc.addDoingState,
              ),
              ChipItem(
                isActive: bloc.state is CompletedAssignScreenState,
                title: 'done'.tr,
                onTap: bloc.addCompletedState,
              ),
              ChipItem(
                isActive: bloc.state is HistoryAssignScreenState,
                title: 'selectSectionPescriptionTitle_3'.tr,
                onTap: bloc.addHistoryState,
              ),
            ],
          ),
        ),
        if (bloc.state is! HistoryAssignScreenState)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 36.h,
            child: ListView.separated(
              key: Key(bloc.state.toString()),
              itemCount: bloc.completedDates.length,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              physics: const BouncingScrollPhysics(),
              reverse: bloc.state is CompletedAssignScreenState,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                final isActive = bloc.currentActiveIndex == i;
                return GestureDetector(
                  onTap: () => bloc.setIndex(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            bloc.currentDate(i).assignScreenFormatter,
                            style: AppTypography.font16.copyWith(
                              color: isActive
                                  ? AppColors.c00ACE3
                                  : AppColors.cBFBFBF,
                              fontWeight:
                                  isActive ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) {
                return Padding(padding: EdgeInsets.only(left: 8.w));
              },
            ),
          ),
      ],
    );
  }
}

class _Data extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AssignBloc>();
    final detailBloc = context.bloc<AssignScreenBloc>();

    if (bloc.assignment.isEmpty) {
      return EmptyAssign();
    }

    if (detailBloc.state is HistoryAssignScreenState) {
      return AssignHistory();
    }

    final tasks = bloc.getTaskInDay(date: detailBloc.activeDate);
    final formattedDay = detailBloc.activeDate.assignScreenFormatter;
    if (tasks.isEmpty) {
      return EmptyOrExpired(
        child: AppIcons.prescriptionsInactive(width: 44.w, height: 44.w),
        text: 'noPrescriptionsPlanTitle'
            .tr
            .replaceAll(RegExp('#DATE#'), formattedDay.toLowerCase()),
      );
    }
    if (!tasks.any((e) => e.completed) &&
        detailBloc.state is! DoingAssignScreenState) {
      String text;
      if (detailBloc.activeDate.isInDay(DateTime.now())) {
        text = 'noPrescriptionsPlanTodayNoIntakesTitle'.tr;
      } else {
        text = 'noPrescriptionsPlanNoIntakesTitle'.tr;
      }
      return EmptyOrExpired(
        child: AppIcons.prescriptionsInactive(
          width: 44.w,
          height: 44.w,
          color: AppColors.cFF3B30,
        ),
        text: text.replaceAll(RegExp('#DATE#'), formattedDay.toLowerCase()),
      );
    }
    if (tasks.where((e) => e.completed).length == tasks.length) {
      String text;
      if (detailBloc.activeDate.isInDay(DateTime.now())) {
        text = 'noPrescriptionsPlanTodayIntakesTitle'.tr;
      } else {
        text = 'noPrescriptionsPlanIntakesTitle'.tr;
      }
      return EmptyOrExpired(
        text: text.replaceAll(RegExp('#DATE#'), formattedDay.toLowerCase()),
        child: AppIcons.complete(
          size: 44.w,
        ),
      );
    }
    final stateTasks = tasks
        .where((e) =>
            e.enable &&
            e.completed == detailBloc.state is CompletedAssignScreenState)
        .toList();
    final now = DateTime.now();
    if (detailBloc.state is DoingAssignScreenState) {
      stateTasks.sort((i, j) => i.dateTime.compareTo(j.dateTime));
    } else {
      stateTasks.sort(
        (i, j) => i.completedDate
            .difference(now)
            .compareTo(j.completedDate.difference(now)),
      );
    }
    return ListView.separated(
      itemCount: stateTasks.length,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemBuilder: (_, i) {
        return AssignItem(task: stateTasks[i]);
      },
      separatorBuilder: (_, __) {
        return Padding(padding: EdgeInsets.only(top: 8.h));
      },
    );
  }
}

class AssignHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AssignBloc>();
    final now = DateTime.now();
    final List<Assignment> active = bloc.assignment
        .where((e) =>
            !e.isStopped &&
            e.endTime.isAfter(now) &&
            e.runTasks.where((e) => e.completed).length != e.runTasks.length)
        .toList();
    final List<Assignment> archive =
        bloc.assignment.where((e) => !active.contains(e)).toList();
    active.sort((i, j) => i.endTime.compareTo(j.endTime));
    archive.sort((i, j) => i.endTime.compareTo(j.endTime));
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (active.isNotEmpty) ...[
          _ListTitle(title: 'actualTextLabel'.tr),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                return _ListItem(assignment: active[i]);
              },
              childCount: active.length,
            ),
          ),
        ],
        if (archive.isNotEmpty) ...[
          _ListTitle(title: 'archiveTextLabel'.tr),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                return _ListItem(assignment: archive[i]);
              },
              childCount: archive.length,
            ),
          ),
        ]
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final Assignment assignment;

  const _ListItem({Key key, this.assignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text;
    final isDisable = assignment.isStopped;
    final count = assignment.runTasks.where((e) => e.enable && e.completed);
    if (isDisable) {
      text = 'prscr_cancelled'.tr;
    } else if (count.isEmpty) {
      text = 'thereWereNoReceptionsText'.tr;
    } else if (count.length == assignment.runTasks.length) {
      text = '${'quantity'.tr}'.replaceAll(RegExp('#COUNT#'), count.length.toString());
    } else {
      final length =
          assignment.runTasks.where((e) => !e.completed && e.enable).length;
      text = '${length.getPluralCountTitle} $length ${length.getPluralCount}';
    }
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return AssignmentNewScreen(assignment: assignment);
                },
              ),
            );
          },
          child: Container(
            constraints: BoxConstraints(
              minHeight: 62.h,
              minWidth: 288.w,
              maxWidth: 288.w,
            ),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 9.w),
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cF5F7FA,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          assignment.type.iconPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignment.name,
                      style: AppTypography.font14.copyWith(
                        color: AppColors.c000000,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        text,
                        style: AppTypography.font14.copyWith(
                          color: AppColors.c9B9B9B,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListTitle extends StatelessWidget {
  final String title;

  const _ListTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 20.h),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            title,
            style: AppTypography.font12.copyWith(
              color: AppColors.c9B9B9B,
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyAssign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 72.h),
          child: BaseCenterWidget(
            child: AppIcons.prescriptionsInactive(
              width: 44.w,
              height: 44.w,
            ),
            text:
                'Здесь будут показываться ваши\nтекущие назначения, история\nвыполнения и список всех\nназначений ',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 35.h),
          child: EmmaFilledButton(
            width: 256.w,
            title: 'addNewPrescriptionLabel'.tr,
            fontSize: Constants.textSize14,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AssignmentNewScreen(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
