import 'package:emma_mobile/app_common/app_common.dart';
import 'package:emma_mobile/app_common/app_common_state.dart';
import 'package:emma_mobile/ui/components/animated/pulse_animated_image.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/intro/greeting_screen.dart';
import 'package:emma_mobile/ui/screens/login/pin_enter_screen.dart';
import 'package:emma_mobile/utils/fonts.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AppCommon>();
    return Scaffold(
      body: BlocListener<AppCommon, AppCommonState>(
        listener: (context, state) {
          if (bloc.isLaunchFirstTime) {
            // ignore: lines_longer_than_80_chars
            //todo: Убрать это дурацкую заглушку, имитация загрузки во время отображения splash screen
            Future.delayed(
              const Duration(seconds: 1),
              () => navigatorReplace(context, GreetingScreen()),
            );
          }
          if (bloc.isRegistrationCompleted == true) {
            navigatorReplace(context, PinEnterScreen());
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PulseAnimatedImage(
                assetName: 'assets/images/logo_symbol.png',
              ),
              const HSpace(54),
              Text(
                'Мы повышаем эффективность Вашего общения с врачом',
                style: AppTypography.font24.copyWith(color: AppColors.c3B4047),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
