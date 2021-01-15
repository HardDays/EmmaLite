import 'package:flutter/material.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  const CustomBottomNavigationBarItem({
    @required this.title,
    @required this.activeIcon,
    @required this.inactiveIcon,
    this.isActive = false,
  });

  final Widget activeIcon;
  final Widget inactiveIcon;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(child: isActive ? activeIcon : inactiveIcon);
  }
}
