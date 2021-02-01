import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/bloc/assign/assign_state.dart';
import 'package:emma_mobile/bloc/assign_screen/assign_screen_bloc.dart';
import 'package:emma_mobile/bloc/assign_screen/assign_screen_state.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/assign_item.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/chip.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/screens/assignment/assignment_new.dart';
import 'package:emma_mobile/ui/screens/assignment/calendar_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AssignBloc>();
    return Scaffold(
      body: BlocProvider(
        create: (_) => AssignScreenBloc(),
        child: BlocBuilder<AssignBloc, AssignState>(
          builder: (context, __) {
            return BlocBuilder<AssignScreenBloc, AssignScreenState>(
              builder: (_, state) {
                return Column(
                  children: [
                    EmmaAppBar(
                      title: 'Назначения',
                      childUpperLine:
                          bloc.assignment.isNotEmpty ? _AppBar() : null,
                      trailing: bloc.assignment.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => CalendarScreen()),
                                );
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 15.h, right: 16.w),
                                child: AppIcons.calendarActive(),
                              ),
                            )
                          : null,
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
          ),
          child: Row(
            children: [
              ChipItem(
                isActive: bloc.state is DoingAssignScreenState,
                title: 'Сделать',
                onTap: bloc.addDoingState,
              ),
              ChipItem(
                isActive: bloc.state is CompletedAssignScreenState,
                title: 'Сделано',
                onTap: bloc.addCompletedState,
              ),
              ChipItem(
                isActive: bloc.state is HistoryAssignScreenState,
                title: 'История',
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 48.h,
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
      return _EmptyAssign();
    }
    final tasks = bloc.getTaskInDay(date: detailBloc.activeDate);
    final formattedDay = detailBloc.activeDate.assignScreenFormatter;
    if (tasks.isEmpty) {
      return _EmptyOrExpired(
        child: AppIcons.prescriptionsInactive(width: 44.w, height: 44.w),
        text: 'На ${formattedDay.toLowerCase()} у вас не запланировано назначений.',
      );
    }
    if (!tasks.any((e) => e.completed)) {
      return _EmptyOrExpired(
        child: AppIcons.prescriptionsInactive(
          width: 44.w,
          height: 44.w,
          color: AppColors.cFF3B30,
        ),
        text:
            '$formattedDay вы не сделали ни одно из запланированных назначений.',
      );
    }
    if (tasks.where((e) => e.completed).length == tasks.length) {
      return _EmptyOrExpired(
        text: 'Поздравляем, вы выполнили все назначения ${formattedDay.toLowerCase()}!',
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

class _EmptyOrExpired extends StatelessWidget {
  final Widget child;
  final String text;

  const _EmptyOrExpired({Key key, this.text, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.h),
      child: _BaseCenterWidget(
        child: child,
        text: text,
      ),
    );
  }
}

class _EmptyAssign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 72.h),
          child: _BaseCenterWidget(
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
            title: 'Добавить первое назначение',
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

class _BaseCenterWidget extends StatelessWidget {
  final Widget child;
  final String text;

  const _BaseCenterWidget({Key key, this.child, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: const BoxDecoration(
            color: AppColors.cFFFFFF,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 4,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              )
            ],
          ),
          child: Center(child: child),
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.h),
          child: SizedBox(
            width: 256.w,
            child: Text(
              text,
              style: AppTypography.font14.copyWith(
                color: AppColors.c9B9B9B,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
