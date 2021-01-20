import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmmaFilledButton extends StatelessWidget {
  const EmmaFilledButton({
    Key key,
    this.title = '',
    this.onTap,
    this.width = double.infinity,
    this.height = 50,
    this.isActive = true,
    this.activeColor = AppColors.c00ACE3,
    this.inactiveColor = AppColors.cCED3DB,
    this.borderRadius = 32,
    this.child,
    this.reverseTap = false,
  }) : super(key: key);

  final double width;
  final double height;
  final double borderRadius;
  final Color activeColor;
  final Color inactiveColor;
  final bool isActive;
  final bool reverseTap;
  final VoidCallback onTap;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isReverseTap = reverseTap ? !isActive : isActive;
    return GestureDetector(
      onTap: isReverseTap ? onTap : null,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(borderRadius),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: isActive ? activeColor : inactiveColor,
          child: SizedBox(
            width: width,
            height: height,
            child: Center(
              child: child ??
                  Text(
                    title,
                    style: AppTypography.font17.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.cFFFFFF,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
