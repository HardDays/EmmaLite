import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class DefaultContainer extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final bool haveDecoration;
  final double minHeight;
  final double width;
  final Color color;

  const DefaultContainer({
    Key key,
    this.child,
    this.onTap,
    this.haveDecoration = true,
    this.minHeight,
    this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minWidth: width ?? 288.w,
          maxWidth: width ?? 288.w,
          minHeight: minHeight ?? 62.h,
        ),
        decoration: BoxDecoration(
          color: color ?? AppColors.cFFFFFF,
          borderRadius: haveDecoration
              ? const BorderRadius.all(Radius.circular(4))
              : null,
          boxShadow: [
            if (haveDecoration)
              BoxShadow(
                color: AppColors.c000000.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: child,
      ),
    );
  }
}
