import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/assignment/assignments_screen.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_new.dart';
import 'package:emma_mobile/ui/screens/profile/profile_screen.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

//todo: Подумать как можно сделать лучше
enum BottomMenuType { main, profile }

class BottomMenu extends StatelessWidget {
  const BottomMenu({this.type = BottomMenuType.main});

  final BottomMenuType type;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 48) / 2;

    switch (type) {
      case BottomMenuType.main:
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomMenuItem(
                    icon: Assets.icons.measurementsInactive.svg(),
                    title: 'Добавить измерение',
                    width: width,
                    onTap: () => navigatorPush(context, MeasurementNewScreen()),
                  ),
                  const WSpace(8),
                  BottomMenuItem(
                    icon: Assets.icons.prescriptionsInactive.svg(),
                    title: 'Добавить назначение',
                    width: width,
                    onTap: () => navigatorPush(context, AssignmentsScreen()),
                  )
                ],
              ),
              const HSpace(16),
              BottomMenuItem(
                  icon: Assets.icons.report.svg(), title: 'Сформировать отчет'),
            ],
          ),
        );
        break;
      case BottomMenuType.profile:
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomMenuItem(
                  icon: Assets.icons.profile.svg(),
                  title: 'Профиль',
                  width: width,
                  onTap: () => navigatorPush(context, ProfileScreen()),
                ),
                const WSpace(8),
                BottomMenuItem(
                  icon: Assets.icons.doctors.svg(),
                  title: 'Мои врачи',
                  width: width,
                )
                // onTap: () => navigatorPush(context, AssignmentsScreen()))
              ],
            ),
            const HSpace(16),
            BottomMenuItem(
              icon: Assets.icons.settings.svg(),
              title: 'Настройки',
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }
}

class BottomMenuItem extends StatelessWidget {
  const BottomMenuItem(
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
      onTap: () => onTap?.call(),
      child: Container(
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: AppColors.cF1F5F9),
          padding: const EdgeInsets.only(
              left: 26.5, right: 26.5, top: 24, bottom: 16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            icon,
            const HSpace(16),
            Text(title,
                textAlign: TextAlign.center,
                style: CustomTextStyles.activeGenderBlock
                    .copyWith(color: AppColors.c3B4047))
          ])),
    );
  }
}
