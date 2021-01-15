import 'package:flutter/material.dart';

class PulseAnimatedImage extends StatefulWidget {
  const PulseAnimatedImage({@required this.assetName, this.size = 70});

  final double size;
  final String assetName;

  @override
  State<StatefulWidget> createState() => _PulseAnimatedImageState();
}

class _PulseAnimatedImageState extends State<PulseAnimatedImage>
    with TickerProviderStateMixin {
  AnimationController motionController;
  Animation motionAnimation;
  double size;

  @override
  void initState() {
    size = widget.size;
    prepareForAnimation();
    super.initState();
  }

  void prepareForAnimation() {
    motionController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.7,
    );

    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.ease,
    );

    motionController.forward();
    motionController.addStatusListener(
      (status) {
        setState(() {
          if (status == AnimationStatus.completed) {
            motionController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            motionController.forward();
          }
        });
      },
    );

    motionController.addListener(() {
      setState(() {
        size = motionController.value * 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.assetName,
      height: size,
      width: size,
      fit: BoxFit.fill,
    );
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }
}
