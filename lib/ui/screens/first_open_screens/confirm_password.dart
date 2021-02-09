import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/ui/components/password/pass_keyboard.dart';
import 'package:emma_mobile/ui/components/password/pass_points.dart';
import 'package:emma_mobile/ui/images.dart';
import 'package:emma_mobile/ui/screens/first_open_screens/biometry_screen.dart';
import 'package:emma_mobile/ui/screens/navigator_screen.dart';
import 'package:emma_mobile/ui/screens/sync/sync_start_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  final List<int> password;

  const ConfirmPasswordScreen({Key key, this.password}) : super(key: key);

  @override
  _ConfirmPasswordScreenState createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  List<int> _password = [];
  bool _haveError = false;

  void _setPassword(List<int> v) {
    _password = v;
    if (_password.length == 4) {
      _haveError = !_password.every((e) => widget.password.contains(e));
      if (_haveError) {
        _password = [];
      }
      setState(() {});
      if (!_haveError) {
        Future.delayed(
          const Duration(milliseconds: 100),
          () async {
            context.bloc<AppSettingsBloc>().setPassword(_password.join(''));
            final local = LocalAuthentication();
            final haveBiometric = await local.canCheckBiometrics;
            final biometrics = await local.getAvailableBiometrics();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => haveBiometric
                    ? FirstBiometryScreen(
                        type: biometrics.first,
                      )
                    : SyncStartScreen(),
              ),
            );
          },
        );
      }
    } else {
      _haveError = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 52.h, bottom: 23.h),
            child: AppImages.logoHeart(height: 52.h, width: 52.w),
          ),
          PassPoints(
            text: 'Подтвердите пароль:',
            haveError: _haveError,
            errorColor: AppColors.cFF3B30,
            errorText: 'Пароли не совпадают',
            activeCount: _password.length,
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: PassKey(
              onChange: _setPassword,
              haveFaceId: false,
              keys: _password,
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => SyncStartScreen(),
                  ),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                child: Text(
                  'Позже',
                  style: AppTypography.font14.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.c00ACE3,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
