import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    this.onSubmit,
    this.labelText,
    this.onTap,
    this.style = CustomTextStyles.textFieldText,
    this.controller,
    this.readOnly = false,
  });

  final String labelText;
  final void Function(String) onSubmit;
  final TextStyle style;
  final bool readOnly;
  final VoidCallback onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap?.call,
      child: TextField(
        controller: controller,
        style: style,
        readOnly: readOnly,
        onSubmitted: (text) => onSubmit?.call(text),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: CustomTextStyles.inactiveGenderBlock,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
