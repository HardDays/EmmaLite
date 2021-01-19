import 'dart:math';

import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_nav_bar_item.dart';
import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/screens/main/main_screen.dart';
import 'package:emma_mobile/ui/screens/measurement/measurements_screen.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(320, 704));
    // HiveBoxes().pulseBox.add(
    //       Pulse(
    //         id: DateTime.now().millisecondsSinceEpoch,
    //         date: DateTime.now().toString(),
    //         pulse: Random().nextInt(160),
    //       ),
    //     );
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
            activeIcon: AppIcons.graphActive(),
            inactiveIcon: AppIcons.graphInactive(),
            title: '',
            isActive: _currentIndex == 0,
          ),
          CustomBottomNavigationBarItem(
            activeIcon: AppIcons.measurementsActive(),
            inactiveIcon: AppIcons.measurementsInactive(),
            title: '',
            isActive: _currentIndex == 1,
          ),
          CustomBottomNavigationBarItem(
            activeIcon: AppIcons.menuAdd(),
            inactiveIcon: AppIcons.menuAdd(),
            title: '',
            isActive: _currentIndex == 2,
          ),
          CustomBottomNavigationBarItem(
            activeIcon: AppIcons.prescriptionsActive(),
            inactiveIcon: AppIcons.prescriptionsInactive(),
            title: '',
            isActive: _currentIndex == 3,
          ),
          CustomBottomNavigationBarItem(
            activeIcon: AppIcons.menuActive(),
            inactiveIcon: AppIcons.menuInactive(),
            title: '',
            isActive: _currentIndex == 4,
          )
        ],
      ),
    );
  }
}
