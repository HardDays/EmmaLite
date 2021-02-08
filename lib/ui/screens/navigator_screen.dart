import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:emma_mobile/ui/screens/assignment/assignments_screen.dart';
import 'package:emma_mobile/ui/screens/main/main_screen.dart';
import 'package:emma_mobile/ui/screens/measurement/measurements_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _currentIndex = 0;

  void _setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget otherScreen;

  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 4) {
      otherScreen = null;
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    sizing: StackFit.expand,
                    index: _currentIndex,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 56.h),
                        child: MainScreen(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 56.h),
                        child: MeasurementScreen(),
                      ),
                      Container(color: AppColors.cF5F7FA),
                      Padding(
                        padding: EdgeInsets.only(bottom: 56.h),
                        child: AssignmentsScreen(),
                      ),
                      otherScreen ?? Container(),
                    ],
                  ),
                ),
              ],
            ),
            BottomNavigationBarCustom(
              onTap: _setIndex,
              activeIndex: _currentIndex,
              otherTabPage: (screen) {
                _setIndex(4);
                otherScreen = screen;
              },
            ),
            // _Bottom(
            //   index: _currentIndex,
            //   onChangeIndex: _setIndex,
            // ),
          ],
        ),
      ),
    );
  }
}
