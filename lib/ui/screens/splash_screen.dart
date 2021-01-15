import 'package:emma_mobile/app_common/app_common.dart';
import 'package:emma_mobile/app_common/app_common_state.dart';
import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:emma_mobile/ui/components/animated/pulse_animated_image.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/intro/greeting_screen.dart';
import 'package:emma_mobile/ui/screens/login/pin_enter_screen.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppCommon, AppCommonState>(
        listener: (context, state) {
          if (state.isLaunchFirstTime) {
            // ignore: lines_longer_than_80_chars
            //todo: Убрать это дурацкую заглушку, имитация загрузки во время отображения splash screen
            Future.delayed(
              const Duration(seconds: 1),
              () => navigatorReplace(context, GreetingScreen()),
            );
          }
          if (state.isRegistrationCompleted == true) {
            navigatorReplace(context, PinEnterScreen());
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PulseAnimatedImage(assetName: Assets.images.logoSymbol.assetName),
              const HSpace(54),
              const Text(
                'Мы повышаем эффективность Вашего общения с врачом',
                style: CustomTextStyles.splashScreen,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
