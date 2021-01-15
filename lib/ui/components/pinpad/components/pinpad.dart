import 'package:emma_mobile/ui/components/pinpad/components/keypad.dart';
import 'package:emma_mobile/ui/components/pinpad/components/pindisplay.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PinPad extends StatefulWidget {
  final void Function(String) onFinished;

  final Widget logo;

  final bool hasError;

  /// required PIN length.
  final int pinLength;

  final Widget keypadBottomLeading;

  /// decoration for the buttons on the KeyPad.
  final Decoration buttonDecoration;

  /// styles for the buttons on the KeyPad
  final TextStyle buttonTextStyle;

  /// decoration for the KeyPad.
  final Decoration keyPadDecoration;

  /// decoration for the PinPad Widget
  final Decoration decoration;

  /// PinPad padding.
  final EdgeInsetsGeometry padding;

  /// PinPad margin
  final EdgeInsetsGeometry margin;

  /// PinPad title. Defaults to Text("Enter PIN")
  final String title;

  /// to mask PIN or not. default is true.
  // final bool maskInput;

  final bool needClear;

  /// to scramble the position of input keys.
  final bool scrambleKeys;

  const PinPad({
    @required this.title,
    this.pinLength = 4,
    this.hasError = false,
    this.scrambleKeys = true,
    this.needClear = false,
    this.keypadBottomLeading,
    this.logo = const HSpace(1),
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.all(0.0),
    this.decoration = const BoxDecoration(),
    this.keyPadDecoration = const BoxDecoration(),
    this.buttonDecoration = const BoxDecoration(),
    this.buttonTextStyle = const TextStyle(),
    this.onFinished,
  });

  @override
  _PinPadState createState() => _PinPadState();

  factory PinPad.useDefault() {
    return const PinPad(title: 'Enter PIN');
  }
}

class _PinPadState extends State<PinPad> {
  List<int> _values;
  String _input = '';

  @override
  void initState() {
    super.initState();
    // _input.addListener(() {
    //   if(_input.value.length == 4) {
    //     widget.onFinished(_input.value);
    //   }
    // });
    _values = InputHelper.getNumbers(scrambleNumbers: widget.scrambleKeys);
  }

  void addValue(String value) {
    setState(() {
      if (_input.isEmpty) {
        _input = value;
      } else {
        _input += value;
        //todo: Сделать рефакторинг этого метода, а лучше всего виджета
        // полностью. Сделано на скорую руку.
      }
    });
    if (_input.length == 4) {
      widget.onFinished(_input);
      clear(null);
    }
  }

  void remove(dynamic) {
    setState(() {
      if (_input.isEmpty) {
        _input = '';
      } else {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      }
    });
  }

  void clear(dynamic) {
    setState(() {
      _input = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: widget.padding,
        margin: widget.margin,
        decoration: widget.decoration,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.logo,
              const HSpace(25),
              Text(widget.title,
                  textAlign: TextAlign.center,
                  style: widget.hasError
                      ? CustomTextStyles.textFieldText
                          .copyWith(color: AppColors.cFF3B30)
                      : CustomTextStyles.textFieldText),
              const HSpace(16),
              PinDisplay(
                pinLength: widget.pinLength,
                input: _input,
                hasError: widget.hasError,
              ),
              const SizedBox(
                height: 40.0,
              ),
              KeyPad(
                numbers: _values,
                addInput: addValue,
                removeInput: remove,
                clear: clear,
                scrambleKeys: widget.scrambleKeys,
                decoration: widget.keyPadDecoration,
                bottomLeadingIcon: widget.keypadBottomLeading,
                buttonDecoration: widget.buttonDecoration,
                buttonTextStyle: widget.buttonTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputHelper {
  static List<int> getNumbers({bool scrambleNumbers}) {
    final numberSet = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
    return numberSet;
  }
}
