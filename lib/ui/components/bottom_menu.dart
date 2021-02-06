import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/assignment/assignment_new.dart';
import 'package:emma_mobile/ui/screens/doctors/doctors_screen.dart';
import 'package:emma_mobile/ui/screens/measurement/select_measurement.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:emma_mobile/ui/screens/profile/profile_screen.dart';

//todo: Подумать как можно сделать лучше
enum BottomMenuType { main, profile }

class BottomMenu extends StatelessWidget {
  const BottomMenu({
    this.type = BottomMenuType.main,
    this.onTap,
    this.otherTabPage,
  });

  final BottomMenuType type;
  final Function onTap;
  final Function(Widget) otherTabPage;

  @override
  Widget build(BuildContext context) {
    final isName = type == BottomMenuType.main;
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        left: 20.w,
        right: 20.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BottomMenuItem(
                icon: isName
                    ? AppIcons.measurementsInactive()
                    : AppIcons.profile(),
                title: isName ? 'Добавить\nизмерение' : 'Профиль',
                width: 137.w,
                onTap: () {
                  onTap?.call();
                  if (isName) {
                    navigatorPush(context, SelectMeasurement());
                  } else {
                    otherTabPage?.call(ProfileScreen());
                  }
                },
              ),
              const Spacer(),
              _BottomMenuItem(
                icon: isName
                    ? AppIcons.prescriptionsInactive()
                    : AppIcons.doctors(),
                title: isName ? 'Добавить\nназначение' : 'Мои врачи',
                width: 137.w,
                onTap: () {
                  onTap?.call();
                  if (isName) {
                    navigatorPush(context, AssignmentNewScreen());
                  } else {
                    otherTabPage?.call(DoctorsScreen());
                  }
                },
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: _BottomMenuItem(
              icon: isName ? AppIcons.report() : AppIcons.settings(),
              title: isName ? 'Сформировать отчет' : 'Настройки',
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomMenuItem extends StatelessWidget {
  const _BottomMenuItem(
      {@required this.icon,
      @required this.title,
      this.width = double.infinity,
      this.onTap});

  final Widget icon;
  final String title;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 109.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.cF1F5F9,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTypography.font16.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.c3B4047,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
