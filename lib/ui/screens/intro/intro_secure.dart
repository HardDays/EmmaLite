import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/buttons/emma_flat_button.dart';
import 'package:emma_mobile/ui/components/intro/intro_logo.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/login/pin_enter_screen.dart';
import 'package:emma_mobile/ui/screens/navigator_screen.dart';
import 'package:flutter/material.dart';

class IntroSecure extends StatelessWidget {
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
              logo: Assets.images.introSecure.image(),
              title: 'Защитите свои данные',
              subTitle:
                  // ignore: lines_longer_than_80_chars
                  'Вы можете настроить вход вриложение через пароль, чтобы никто не мог узнать ваши данные.',
            ),
            const HSpace(32),
            EmmaFilledButton(
              title: 'Создать пароль',
              onTap: () => navigatorReplace(context, PinEnterScreen()),
            ),
            const HSpace(24),
            EmmaFlatButton(
              title: 'Сделаю позже в Настройках',
              onTap: () => navigatorReplace(context, NavigatorScreen()),
            )
          ],
        ),
      ),
    );
  }
}
