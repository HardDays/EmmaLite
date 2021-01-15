import 'package:emma_mobile/app_common/app_common.dart';
import 'package:emma_mobile/app_common/app_common_state.dart';
import 'package:emma_mobile/ui/components/snackbars/snackbar.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/intro/biometry_request_screen.dart';
import 'package:emma_mobile/ui/screens/navigator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinEnterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    final bloc = context.bloc<AppCommon>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<AppCommon, AppCommonState>(
        listener: (contest, state) {
          if (bloc.pinCode != null) {
            showSnackBar(context, 'Сохранено');
            if (bloc.currentBiometricType != null) {
              navigatorReplace(context, BiometryRequestScreen());
            } else {
              navigatorReplace(context, NavigatorScreen());
            }
          }
        },
        builder: (context, state) {
          return const SizedBox();
          // if (bloc.tempCode?.error != null) {
          //   return Center(
          //     child: PinPad(
          //       logo: Assets.images.logoSymbol.image(width: 60, height: 60),
          //       title: bloc.tempCode?.error?.message,
          //       hasError: true,
          //       onFinished: (pin) => context.read<AppCommon>().saveTemp(pin),
          //     ),
          //   );
          // }
          // if (bloc.isRegistrationCompleted == true) {
          //   return PinPad(
          //     logo: Assets.images.logoSymbol.image(width: 60, height: 60),
          //     title: bloc.tempCode?.error?.message,
          //     keypadBottomLeading:
          //         Assets.images.touchId.image(width: 40, height: 40),
          //     onFinished: (pin) => context.read<AppCommon>().checkPin(pin),
          //   );
          // }
          // return Center(
          //   child: bloc.tempCode?.payload == null
          //       ? PinPad(
          //           logo: Assets.images.logoSymbol.image(width: 45, height: 45),
          //           title: 'Придумайте пароль, чтобы защитить свои данные:',
          //           onFinished: (pin) =>
          //               context.read<AppCommon>().saveTemp(pin),
          //         )
          //       : PinPad(
          //           logo: Assets.images.logoSymbol.image(width: 45, height: 45),
          //           title: 'Подтвердите пароль',
          //           onFinished: (pin) =>
          //               context.read<AppCommon>().checkTemp(pin),
          //         ),
          // );
        },
      ),
    );
  }
}
