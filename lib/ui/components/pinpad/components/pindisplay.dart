import 'package:emma_mobile/ui/components/pinpad/components/pin_put.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class PinDisplay extends StatelessWidget {
  final String input;

  final bool hasError;

  /// required PIN length.
  final int pinLength;

  /// PIN display decoration
  final Decoration decoration;

  /// PIN display padding
  final EdgeInsetsGeometry padding;

  ///PIN display margin
  final EdgeInsetsGeometry margin;

  const PinDisplay({
    this.pinLength,
    this.input,
    this.hasError,
    this.decoration,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: decoration,
      padding: padding,
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: !hasError
            ? Iterable.generate(
                pinLength,
                (n) => PinPut(
                      color: n >= input.length
                          ? AppColors.cFFFFFF
                          : AppColors.c00ACE3,
                    )).toList()
            : Iterable.generate(
                pinLength,
                (n) => const PinPut(
                  color: Colors.red,
                ),
              ).toList(),
      ),
    );
  }
}
