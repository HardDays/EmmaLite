import 'dart:math';

import 'package:emma_mobile/ui/components/icons.dart';
import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  const AddButton({this.onTap});

  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  bool _isFirstCall = true;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: -pi / 4).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _animation.value,
      child: GestureDetector(
        onTap: widget.onTap?.call,
        child: AppIcons.menuAdd(),
      ),
    );
  }

  void animateIcon() {
    setState(() => _isFirstCall = !_isFirstCall);
    _isFirstCall ? _controller.forward() : _controller.reverse();
  }
}
