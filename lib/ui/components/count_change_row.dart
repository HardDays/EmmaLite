import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class CountChangeRow extends StatefulWidget {
  final int initialValue;
  final Function(int v) onChange;

  const CountChangeRow({
    Key key,
    this.initialValue,
    this.onChange,
  }) : super(key: key);

  @override
  _CountChangeRowState createState() => _CountChangeRowState();
}

class _CountChangeRowState extends State<CountChangeRow> {
  int _value;

  @override
  void initState() {
    _value = widget.initialValue ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.cF5F7FA,
      child: SizedBox(
        height: 50.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Circle(
                child: AppIcons.minus(),
                onTap: () {
                  if (_value != 0) {
                    setState(() {
                      _value--;
                    });
                    widget.onChange?.call(_value);
                  }
                },
              ),
              Text(
                _value.toString(),
                style: AppTypography.font16.copyWith(color: AppColors.c4A4A4A),
              ),
              _Circle(
                onTap: () {
                  setState(() {
                    _value++;
                  });
                  widget.onChange?.call(_value);
                },
                child: AppIcons.plus(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final Widget child;
  final Function onTap;

  const _Circle({Key key, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 5.h,
        ),
        child: Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.c00ACE3,
              width: 1.w,
            ),
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
