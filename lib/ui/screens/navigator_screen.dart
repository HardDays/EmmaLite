import 'package:animated_rotation/animated_rotation.dart';
import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_nav_bar_item.dart';
import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(320, 704));
    return Scaffold(
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
                    MainScreen(),
                    MeasurementScreen(),
                    Container(color: AppColors.cF5F7FA),
                    AssignmentsScreen(),
                    Container(),
                  ],
                ),
              ),
              SizedBox(height: 56.h),
            ],
          ),
          BottomNavigationBarCustom(
            onTap: _setIndex,
            activeIndex: _currentIndex,
          ),
          // _Bottom(
          //   index: _currentIndex,
          //   onChangeIndex: _setIndex,
          // ),
        ],
      ),
    );
  }
}

class _Bottom extends StatefulWidget {
  final Function(int v) onChangeIndex;
  final int index;

  const _Bottom({Key key, this.onChangeIndex, this.index}) : super(key: key);

  @override
  __BottomState createState() => __BottomState();
}

class __BottomState extends State<_Bottom> with SingleTickerProviderStateMixin {
  AnimationController _plusController;
  AnimationController _otherController;

  @override
  void initState() {
    _plusController = AnimationController(vsync: this, duration: duration);
    _otherController = AnimationController(vsync: this, duration: duration);
    super.initState();
  }


  bool _activePlus = false;

  bool _lock = false;

  final duration = Duration(milliseconds: 250);

  void _plusTap() {
    _activePlus = !_activePlus;
    setState(() {});
  }

  @override
  void dispose() {
    _plusController.dispose();
    _otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cFFFFFF,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.h,
            color: AppColors.cE6E9EB,
          ),
          SizedBox(
            height: 56.h,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56.h,
                  child: Row(
                    children: [
                      CustomBottomNavigationBarItem(
                        activeIcon: AppIcons.graphActive(),
                        inactiveIcon: AppIcons.graphInactive(),
                        isActive: widget.index == 0,
                        onTap: () => widget.onChangeIndex(0),
                      ),
                      CustomBottomNavigationBarItem(
                        activeIcon: AppIcons.measurementsActive(),
                        inactiveIcon: AppIcons.measurementsInactive(),
                        isActive: widget.index == 1,
                        onTap: () => widget.onChangeIndex(0),
                      ),
                      SizedBox(width: 44.w),
                      CustomBottomNavigationBarItem(
                        activeIcon: AppIcons.prescriptionsActive(),
                        inactiveIcon: AppIcons.prescriptionsInactive(),
                        isActive: widget.index == 3,
                        onTap: () => widget.onChangeIndex(3),
                      ),
                      CustomBottomNavigationBarItem(
                        activeIcon: AppIcons.menuActive(),
                        inactiveIcon: AppIcons.menuInactive(),
                        isActive: widget.index == 4,
                        onTap: () {},
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 6.h,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _plusTap();
                      },
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 44.h,
                          maxHeight: 44.h,
                        ),
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: AppColors.c00ACE3,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 172, 227, 0.3),
                                offset: Offset(0, 10),
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: Center(
                            child: AnimatedRotation(
                              duration: duration,
                              angle: _activePlus ? -45 : 0,
                              child: AppIcons.plus(
                                color: AppColors.cFFFFFF,
                                size: 20.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
