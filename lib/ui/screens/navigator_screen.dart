import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_nav_bar_item.dart';
import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:emma_mobile/ui/screens/main/main_screen.dart';
import 'package:emma_mobile/ui/screens/measurement/measurements_screen.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                MainScreen(),
                MeasurementScreen(),
                Container(color: AppColors.cF5F7FA),
                Material(
                  child: Center(
                    child: Text(
                      'Раздел в разработке',
                      style: CustomTextStyles.generalAppBarTitle.copyWith(
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarCustom(
        onTap: (index) => {setState(() => _currentIndex = index)},
        items: [
          CustomBottomNavigationBarItem(
            activeIcon: Assets.icons.graphActive.svg(),
            inactiveIcon: Assets.icons.graphInactive.svg(),
            title: '',
            isActive: _currentIndex == 0,
          ),
          CustomBottomNavigationBarItem(
            activeIcon: Assets.icons.measurementsActive.svg(),
            inactiveIcon: Assets.icons.measurementsInactive.svg(),
            title: '',
            isActive: _currentIndex == 1,
          ),
          CustomBottomNavigationBarItem(
            activeIcon: Assets.icons.menuAdd.svg(),
            inactiveIcon: Assets.icons.menuAdd.svg(),
            title: '',
            isActive: _currentIndex == 2,
          ),
          CustomBottomNavigationBarItem(
            activeIcon: Assets.icons.prescriptionsActive.svg(),
            inactiveIcon: Assets.icons.prescriptionsInactive.svg(),
            title: '',
            isActive: _currentIndex == 3,
          ),
          CustomBottomNavigationBarItem(
            activeIcon: Assets.icons.menuActive.svg(),
            inactiveIcon: Assets.icons.menuInactive.svg(),
            title: '',
            isActive: _currentIndex == 4,
          )
        ],
      ),
    );
  }
}
