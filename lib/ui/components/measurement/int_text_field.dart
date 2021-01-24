import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatefulWidget {
  final String label;
  final Function(String s) onChange;
  final bool isInt;
  final TextInputFormatter formatter;

  const InputTextField({
    Key key,
    this.label,
    this.onChange,
    this.isInt = true,
    this.formatter,
  }) : super(key: key);

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController()..addListener(_listener);
    super.initState();
  }

  void _listener() {
    if (widget.onChange != null) widget?.onChange(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 63.h,
          maxWidth: 288.w,
        ),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: _controller,
          inputFormatters: widget.formatter == null
              ? [
                  widget.isInt
                      ? FilteringTextInputFormatter.digitsOnly
                      : FilteringTextInputFormatter.allow(
                          RegExp(r'\d+(\.{0,1}\d{0,})'),
                        )
                ]
              : [widget.formatter],
          style: AppTypography.font16.copyWith(color: AppColors.c4A4A4A),
          // onChanged: widget.onChange,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelStyle: AppTypography.font14.copyWith(color: AppColors.c9B9B9B),
            labelText: widget.label,
          ),
        ),
      ),
    );
  }
}
