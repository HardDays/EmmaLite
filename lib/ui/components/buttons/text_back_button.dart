import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:flutter/material.dart';

class TextBackButton extends StatelessWidget {
  const TextBackButton({@required this.title, Key key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigatorPop(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(title, style: CustomTextStyles.textBackButton)
        
      )
    );
  }
}
