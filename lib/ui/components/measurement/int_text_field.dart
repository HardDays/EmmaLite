import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatefulWidget {
  final String label;
  final Function(String s) onChange;
  final bool isInt;
  final TextInputFormatter formatter;
  final TextInputType type;
  final String value;
  final bool haveFormatter;
  final bool enable;
  final String initialValue;
  final int maxLines;
  final int maxLength;
  final TextEditingController controller;
  final RegExp formatRegExp;

  const InputTextField({
    Key key,
    this.label,
    this.onChange,
    this.isInt = true,
    this.formatter,
    this.type,
    this.value,
    this.haveFormatter = true,
    this.enable = true,
    this.initialValue,
    this.maxLines = 1,
    this.maxLength,
    this.controller,
    this.formatRegExp,
  }) : super(key: key);

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue)
      ..addListener(_listener);
    super.initState();
  }

  bool _validate = true;

  void _listener() {
    if (widget.onChange != null) {
      widget?.onChange(_controller.text);
    }
    if (widget.formatRegExp != null) {
      setState(() {
        _validate = widget.formatRegExp.hasMatch(_controller.text);
      });
    }
  }

  @override
  void didUpdateWidget(covariant InputTextField oldWidget) {
    if (widget.value != _controller.text && widget.value != null) {
      _controller.text = widget.value;
    }
    super.didUpdateWidget(oldWidget);
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
          keyboardType: widget.type ?? TextInputType.number,
          controller: _controller,
          maxLines: widget.maxLines,
          enabled: widget.enable,
          autofocus: false,
          maxLength: widget.maxLength,
          inputFormatters: widget.haveFormatter
              ? widget.formatter == null
                  ? [
                      widget.isInt
                          ? FilteringTextInputFormatter.digitsOnly
                          : FilteringTextInputFormatter.allow(
                              RegExp(r'\d+(\.{0,1}\d{0,})'),
                            )
                    ]
                  : [widget.formatter]
              : [],
          style: AppTypography.font16.copyWith(color: AppColors.c4A4A4A),
          // onChanged: widget.onChange,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelStyle: AppTypography.font14.copyWith(
              color: _validate ? AppColors.c9B9B9B : AppColors.cFF3B30,
            ),
            labelText: widget.label,
          ),
        ),
      ),
    );
  }
}
