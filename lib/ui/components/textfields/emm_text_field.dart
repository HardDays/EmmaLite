import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmmaTextField extends StatefulWidget {
  const EmmaTextField({
    Key key,
    this.height = 62,
    this.width = double.infinity,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.withPicker = false,
    this.autoFocus = false,
    this.textEditingController,
    this.labelText,
    this.onSubmit,
    this.borderRadius = 4,
    this.boxShadows,
  }) : super(key: key);

  final String labelText;
  final void Function(String) onSubmit;
  final double height;
  final VoidCallback onTap;
  final double width;
  final void Function(String) onChanged;
  final bool readOnly;
  final bool withPicker;
  final bool autoFocus;
  final double borderRadius;
  final TextInputType keyboardType;
  final List<BoxShadow> boxShadows;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController textEditingController;

  @override
  State<StatefulWidget> createState() => _EmmaTextFieldState();
}

class _EmmaTextFieldState extends State<EmmaTextField> {
  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: AppColors.cFFFFFF,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      boxShadow: widget.boxShadows ??
          const BoxShadow(
            color: AppColors.c0D000000,
            offset: Offset(0, 2),
            spreadRadius: 0,
            blurRadius: 4,
          ),
    );

    return Container(
      decoration: decoration,
      height: widget.height,
      padding: const EdgeInsets.only(left: 20),
      child: widget.withPicker
          ? GestureDetector(
              onTap: () => widget.onTap?.call(),
              child: AbsorbPointer(child: _buildField(context)),
            )
          : _buildField(context),
    );
  }

  Widget _buildField(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      onChanged: (text) => {widget.onChanged(text)},
      onSubmitted: (text) => widget.onSubmit(text),
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      controller: widget.textEditingController,
      style: CustomTextStyles.textFieldText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: CustomTextStyles.inactiveGenderBlock,
        border: InputBorder.none,
      ),
    );
  }
}
