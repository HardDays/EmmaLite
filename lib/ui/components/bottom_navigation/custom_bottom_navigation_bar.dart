import 'package:animated_rotation/animated_rotation.dart';
import 'package:emma_mobile/ui/components/bottom_menu.dart';
import 'package:emma_mobile/ui/components/bottom_navigation/custom_bottom_nav_bar_item.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///todo: Переписать виджет, сделать более оптимальным
///Убрать этот гавнокод

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({
    Key key,
    this.onTap,
    this.items,
    this.animate,
  }) : super(key: key);

  final void Function(int) onTap;
  final VoidCallback animate;
  final List<CustomBottomNavigationBarItem> items;

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

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    heightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: AppColors.cFFFFFF,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          type == BottomMenuType.main
              ? SizedBox(
                  height: heightAnimation.value,
                  child: const BottomMenu(),
                )
              : SizedBox(
                  height: heightAnimation2.value,
                  child: const BottomMenu(type: BottomMenuType.profile),
                ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.items.length,
              (index) {
                if (index == 2) {
                  return GestureDetector(
                    onTap: () => {
                      setState(() => type = BottomMenuType.main),
                      _animate()
                    },
                    child: AnimatedRotation(
                      angle: angle,
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 300),
                      child: AppIcons.menuAdd(),
                    ),
                  );
                } else if (index == 4) {
                  return GestureDetector(
                    onTap: () => {
                      setState(() => type = BottomMenuType.profile),
                      _test()
                    },
                    child: Transform.translate(
                      offset: Offset(0, animation.value),
                      child: widget.items[index].inactiveIcon,
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () => widget.onTap?.call(index),
                  child: Transform.translate(
                    offset: Offset(0, animation.value),
                    child: widget.items[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
