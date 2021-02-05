import 'package:animated_rotation/animated_rotation.dart';
import 'package:emma_mobile/ui/components/bottom_menu.dart';
import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_nav_bar_item.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

///todo: Переписать виджет, сделать более оптимальным
///Убрать этот гавнокод

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({
    Key key,
    this.onTap,
    this.activeIndex,
    this.otherTabPage,
  }) : super(key: key);

  final void Function(int) onTap;
  final int activeIndex;
  final Function(Widget) otherTabPage;

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom>
    with TickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> heightAnimation;
  Animation<double> heightAnimation2;
  AnimationController controller;
  AnimationController heightController;
  Tween<double> tween = Tween<double>(begin: 0, end: 50);
  Tween<double> tweenHeight = Tween<double>(begin: 0, end: 300);
  int angle = 0;
  BottomMenuType type;

  static const _duration = Duration(milliseconds: 200);

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: _duration);
    heightController = AnimationController(vsync: this, duration: _duration);

    animation = tween.animate(controller);
    heightAnimation = tweenHeight.animate(controller);
    heightAnimation2 = tweenHeight.animate(heightController);

    type = BottomMenuType.main;
    animation.addListener(() => setState(() {}));
    heightAnimation.addListener(() => setState(() {}));
    heightAnimation2.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1.h,
          color: AppColors.cE6E9EB,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: AppColors.cFFFFFF,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              type == BottomMenuType.main
                  ? SizedBox(
                      height: heightAnimation.value,
                      child: BottomMenu(
                        onTap: _animate,
                      ),
                    )
                  : SizedBox(
                      height: heightAnimation2.value,
                      child: BottomMenu(
                        type: BottomMenuType.profile,
                        onTap: _animate,
                        otherTabPage: widget.otherTabPage,
                      ),
                    ),
              SizedBox(
                height: 56.h,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      bottom: -(controller.value * 56.h),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 56.h,
                        child: Row(
                          children: [
                            CustomBottomNavigationBarItem(
                              activeIcon: AppIcons.graphActive(),
                              inactiveIcon: AppIcons.graphInactive(),
                              isActive: widget.activeIndex == 0,
                              onTap: () => widget.onTap(0),
                            ),
                            CustomBottomNavigationBarItem(
                              activeIcon: AppIcons.measurementsActive(),
                              inactiveIcon: AppIcons.measurementsInactive(),
                              isActive: widget.activeIndex == 1,
                              onTap: () => widget.onTap(1),
                            ),
                            SizedBox(width: 44.w),
                            CustomBottomNavigationBarItem(
                              activeIcon: AppIcons.prescriptionsActive(),
                              inactiveIcon: AppIcons.prescriptionsInactive(),
                              isActive: widget.activeIndex == 3,
                              onTap: () => widget.onTap(3),
                            ),
                            CustomBottomNavigationBarItem(
                              activeIcon: AppIcons.menuActive(),
                              inactiveIcon: AppIcons.menuInactive(),
                              isActive: heightController.value > 0 ||
                                  widget.activeIndex == 4,
                              onTap: () {
                                _animate();
                                setState(() => type = BottomMenuType.profile);
                                _test();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => type = BottomMenuType.main);
                          _animate();
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
                                angle: -angle,
                                curve: Curves.linearToEaseOut,
                                duration: _duration,
                                child: AppIcons.plus(
                                  color: AppColors.cFFFFFF,
                                  size: 20.h,
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
        ),
      ],
    );
  }

  void _animate() {
    if (heightAnimation2.value == 300) {
      heightController.reverse();
    }
    if (angle == 0) {
      setState(() => angle = 45);
    } else {
      setState(() => angle = 0);
    }
    controller.isCompleted ? controller.reverse() : controller.forward();
  }

  void _test() {
    heightController.isCompleted
        ? heightController.reverse()
        : heightController.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    heightController.dispose();
    super.dispose();
  }
}
