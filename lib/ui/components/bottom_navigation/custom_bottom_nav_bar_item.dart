import 'package:flutter/material.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  const CustomBottomNavigationBarItem({
    @required this.activeIcon,
    @required this.inactiveIcon,
    this.isActive = false,
    this.onTap,
  });

  final Widget activeIcon;
  final Widget inactiveIcon;
  final bool isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(child: isActive ? activeIcon : inactiveIcon),
      ),
    );
  }
}
