import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:flutter/material.dart';

class IntroLogo extends StatelessWidget {
  const IntroLogo({this.logo, this.title = '', this.subTitle = ''});

  final Widget logo;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Assets.images.intro.image()),
        const HSpace(32),
        Text(
          title,
          style: CustomTextStyles.introLogoTitle,
          textAlign: TextAlign.center,
        ),
        const HSpace(16),
        Text(
          subTitle,
          style: CustomTextStyles.introLogoSubtitle,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
