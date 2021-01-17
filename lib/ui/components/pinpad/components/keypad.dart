import 'package:emma_mobile/ui/images.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyPad extends StatelessWidget {
  /// decoration for the KeyPad.
  final Decoration decoration;

  /// decoration for the buttons on the KeyPad.
  final Decoration buttonDecoration;

  /// to scramble the position of input keys.
  final bool scrambleKeys;

  final ValueChanged<String> addInput;

  final ValueChanged removeInput;

  final Widget bottomLeadingIcon;

  final ValueChanged clear;

  final List<int> numbers;

  /// styles for the buttons on the KeyPad
  final TextStyle buttonTextStyle;

  const KeyPad({
    this.numbers,
    this.addInput,
    this.removeInput,
    this.clear,
    this.scrambleKeys,
    this.decoration,
    this.bottomLeadingIcon,
    this.buttonDecoration,
    this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Column(
        children: <Widget>[
          _buildRow(context, numbers.sublist(0, 3)),
          const SizedBox(height: 15),
          _buildRow(context, numbers.sublist(3, 6)),
          const SizedBox(height: 15),
          _buildRow(context, numbers.sublist(6, 9)),
          const SizedBox(height: 15),
          _buildLastRow(context)
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<int> inputs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: inputs
          .map(
            (value) => GestureDetector(
              onTap: () =>
                  value.toString().isNotEmpty && value.toString().length <= 4
                      ? addInput(value.toString())
                      : null,
              child: Container(
                width: MediaQuery.of(context).size.height * 75 / 812,
                height: MediaQuery.of(context).size.height * 75 / 812,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cEBEEF3,
                ),
                child: Center(
                  child: Text(
                    value.toString(),
                    style: CustomTextStyles.keypadItem,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildLastRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: 75,
          height: 75,
          child: Center(child: bottomLeadingIcon),
        ),
        GestureDetector(
          onTap: () => addInput(numbers.last.toString()),
          child: Container(
            padding: const EdgeInsets.only(
              left: 25,
              right: 27,
              top: 16,
              bottom: 15,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.cEBEEF3,
            ),
            child: Text(
              numbers.last.toString(),
              style: CustomTextStyles.keypadItem,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => clear(null),
          child: SizedBox(
            width: 75,
            height: 75,
            child: AppImages.delete(),
          ),
        )
      ],
    );
  }
}
