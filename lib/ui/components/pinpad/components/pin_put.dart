import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class PinPut extends StatelessWidget {
  final Color color;

  const PinPut({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.cEBEEF3),
        color: color,
      ),
    );
  }
}
