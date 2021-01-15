import 'package:emma_mobile/app_common/app_common.dart';
import 'package:emma_mobile/app_common/app_common_state.dart';
import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/buttons/emma_flat_button.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/home/root_screen.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class BiometryRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<AppCommon, AppCommonState>(
      listener: (context, state) {
        if (state.biometryGranted == true) {
          navigatorReplace(context, RootScreen());
        }
      },
      listenWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state.currentBiometricType != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                state.currentBiometricType == BiometricType.face
                    ? Assets.images.faceId.image()
                    : Assets.images.touchId.image(),
                const HSpace(50),
                Text(
                  // ignore: lines_longer_than_80_chars
                  "Хотите использовать ${state.currentBiometricType == BiometricType.face ? "Face ID" : "Touch ID"}",
                  style: CustomTextStyles.introLogoTitle,
                ),
                const HSpace(16),
                const Text(
                  'Это позволит входить в приложение без пароля.',
                  style: CustomTextStyles.textFieldText,
                  textAlign: TextAlign.center,
                ),
                const HSpace(80),
                EmmaFilledButton(
                  title:
                      // ignore: lines_longer_than_80_chars
                      "Да, использовать ${state.currentBiometricType == BiometricType.face ? "Face" : "Touch"} ID",
                  onTap: () => context.read<AppCommon>().grantBiometry(),
                ),
                const HSpace(24),
                EmmaFlatButton(
                  title: 'Позже',
                  onTap: () => navigatorReplace(context, RootScreen()),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
