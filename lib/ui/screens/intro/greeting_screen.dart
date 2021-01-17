import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/buttons/emma_flat_button.dart';
import 'package:emma_mobile/ui/components/intro/intro_logo.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/images.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/intro/intro_secure.dart';
import 'package:emma_mobile/ui/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class GreetingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 73, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            IntroLogo(
              logo: AppImages.intro(),
              title: 'Давай знакомиться?',
              subTitle:
                  // ignore: lines_longer_than_80_chars
                  'Заполните сразу свой профиль, что вы могли формировать отчеты о вашем самочувствии. Эти данные увидит только ваш врач.',
            ),
            const HSpace(32),
            EmmaFilledButton(
              title: 'Заполнить профиль',
              onTap: () => navigatorReplace(context, ProfileScreen()),
            ),
            const HSpace(24),
            EmmaFlatButton(
              title: 'Позже',
              onTap: () => navigatorReplace(context, IntroSecure()),
            )
          ],
        ),
      ),
    );
  }
}
