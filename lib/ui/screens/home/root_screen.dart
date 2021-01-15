import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_nav_bar_item.dart';
import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:emma_mobile/ui/screens/main/main_screen.dart';
import 'package:emma_mobile/ui/screens/measurement/measurements_screen.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _tabBuilder(context, _currentIndex),
        bottomNavigationBar: BottomNavigationBarCustom(
            onTap: (index) => {setState(() => _currentIndex = index)},
            items: [
              CustomBottomNavigationBarItem(
                  activeIcon: Assets.icons.graphActive.svg(),
                  inactiveIcon: Assets.icons.graphInactive.svg(),
                  title: '',
                  isActive: _currentIndex == 0),
              CustomBottomNavigationBarItem(
                  activeIcon: Assets.icons.measurementsActive.svg(),
                  inactiveIcon: Assets.icons.measurementsInactive.svg(),
                  title: '',
                  isActive: _currentIndex == 1),
              CustomBottomNavigationBarItem(
                  activeIcon: Assets.icons.menuAdd.svg(),
                  inactiveIcon: Assets.icons.menuAdd.svg(),
                  title: '',
                  isActive: _currentIndex == 2),
              CustomBottomNavigationBarItem(
                  activeIcon: Assets.icons.prescriptionsActive.svg(),
                  inactiveIcon: Assets.icons.prescriptionsInactive.svg(),
                  title: '',
                  isActive: _currentIndex == 3),
              CustomBottomNavigationBarItem(
                  activeIcon: Assets.icons.menuActive.svg(),
                  inactiveIcon: Assets.icons.menuInactive.svg(),
                  title: '',
                  isActive: _currentIndex == 4)
            ]));
  }

  Widget _tabBuilder(BuildContext context, int index) {
    switch (index) {
      case 0:
        return MainScreen();
      case 1:
        return MeasurementScreen();
      case 2:
        return Container(color: AppColors.cF5F7FA);
      case 3:
        return Material(
          child: Center(
            child: Text(
              'Раздел в разработке',
              style:
                  CustomTextStyles.generalAppBarTitle.copyWith(fontSize: 28),
            ),
          ),
        );
      case 4:
        return Container(color: AppColors.cF5F7FA);
    }
    return Container();
  }
}
