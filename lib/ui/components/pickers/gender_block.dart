import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class GenderBlock extends StatefulWidget {
  const GenderBlock(
      {Key key,
      this.title = '',
      this.width = double.infinity,
      this.height = 58,
      this.borderRadius = 4,
      this.activeColor = AppColors.c00ACE3,
      this.inactiveColor = AppColors.cFFFFFF,
      this.boxShadows,
      this.isActive,
      this.onTap})
      : super(key: key);

  final String title;
  final double width;
  final double height;
  final double borderRadius;
  final Color activeColor;
  final Color inactiveColor;
  final List<BoxShadow> boxShadows;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() => _GenderBlockState();
}

class _GenderBlockState extends State<GenderBlock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap?.call,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          boxShadow: widget.boxShadows ??
              [
                const BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: AppColors.c0D000000,
                  offset: Offset(0, 2),
                )
              ],
          color: widget.isActive ? widget.activeColor : widget.inactiveColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: widget.isActive
                ? CustomTextStyles.activeGenderBlock
                : CustomTextStyles.inactiveGenderBlock,
          ),
        ),
      ),
    );
  }
}
