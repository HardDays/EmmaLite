
import 'package:emma_mobile/ui/components/pickers/gender_block.dart';
import 'package:flutter/material.dart';

class GenderPicker extends StatefulWidget {
  const GenderPicker({this.onSubmit});

  final void Function(String) onSubmit;

  @override
  State<StatefulWidget> createState() => _GenderPickState();

}

class _GenderPickState extends State<GenderPicker> {

  int _currentGenderBlock = 0;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 44) / 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GenderBlock(
          onTap: () {
            setState(() => _currentGenderBlock = 0);
            widget.onSubmit?.call('male');
          },
          title: 'Мужской',
          width: width,
          isActive: _currentGenderBlock == 0,
        ),
        GenderBlock(
          onTap: () {
            setState(() => _currentGenderBlock = 1);
            widget.onSubmit?.call('female');
          },
          title: 'Женский',
          width: width,
          isActive: _currentGenderBlock != 0,
        )
      ]
    );
  }

}