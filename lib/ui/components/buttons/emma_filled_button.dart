import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmmaFilledButton extends StatelessWidget {
  const EmmaFilledButton({
    Key key,
    this.title = '',
    this.onTap,
    this.width = double.infinity,
    this.height,
    this.isActive = true,
    this.activeColor = AppColors.c00ACE3,
    this.inactiveColor = AppColors.cCED3DB,
    this.borderRadius = 32,
    this.child,
    this.reverseTap = false,
    this.fontSize,
    this.haveShadow = true,
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
  final double fontSize;
  final bool haveShadow;

  @override
  Widget build(BuildContext context) {
    final isReverseTap = reverseTap ? !isActive : isActive;
    return GestureDetector(
      onTap: isReverseTap ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive ? activeColor : inactiveColor,
          boxShadow: haveShadow
              ? [
                  if (haveShadow)
                    const BoxShadow(
                      color: Color.fromRGBO(0, 172, 227, 0.3),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  else
                    const BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                ]
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: SizedBox(
          width: width,
          height: height ?? 44.h,
          child: Center(
            child: child ??
                Text(
                  title,
                  style: AppTypography.font17.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize,
                    color: AppColors.cFFFFFF,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
