import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/ui/components/password/pass_keyboard.dart';
import 'package:emma_mobile/ui/components/password/pass_points.dart';
import 'package:emma_mobile/ui/images.dart';
import 'package:emma_mobile/ui/screens/first_open_screens/first_open.dart';
import 'package:emma_mobile/ui/screens/navigator_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  Animation<double> _firstScaleAnimation;
  Animation<double> _pulse;
  Animation<double> _move;
  Animation<double> _passOpacity;
  Animation<double> _passwordAnimation;

  BiometricType _biometricType;

  List<int> _passwordValues = [];

  bool _haveError = false;

  String _storePassword;

  @override
  void initState() {
    LocalAuthentication().getAvailableBiometrics().then((value) {
      if (value.isNotEmpty) {
        _biometricType = value.first;
      }
    });

    _controller = AnimationController(
      value: 0,
      duration: const Duration(seconds: 7),
      vsync: this,
    )..addListener(_sizeListener);

    _controller2 = AnimationController(
      value: 0,
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..addListener(_sizeListener2);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _controller.forward();
        Future.delayed(
          const Duration(milliseconds: 1300),
          () {
            _controller2.repeat(reverse: true);
            Future.delayed(
              const Duration(seconds: 3),
              () {
                _controller2.stop();
                final settingsBloc = context.bloc<AppSettingsBloc>();
                if (settingsBloc.appSettings.isFirstRun) {
                  settingsBloc.setFirstRun();
                  _controller.stop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => FirstOpenScreen()),
                  );
                } else if ((settingsBloc.appSettings.password == null ||
                        settingsBloc.appSettings.usePassword != true) &&
                    settingsBloc.appSettings.useFaceId != true) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => NavigatorScreen()),
                  );
                } else {
                  _storePassword = settingsBloc.appSettings.password;
                }
              },
            );
          },
        );
      },
    );

    _firstScaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.1, curve: Curves.easeInOutSine),
      ),
    );

    _pulse = Tween<double>(
      begin: 0,
      end: 0.12,
    ).animate(_controller2);

    _move = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.8, curve: Curves.easeInOutSine),
      ),
    );

    _passOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 0.9, curve: Curves.easeInOutSine),
      ),
    );

    _passwordAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.9, 1, curve: Curves.easeInOutCubic),
      ),
    );

    super.initState();
  }

  void _sizeListener() {
    setState(() {});
  }

  void _sizeListener2() {
    setState(() {});
  }

  void _setPassword(List<int> v) {
    _passwordValues = v;
    if (_passwordValues.length == 4) {
      _haveError = _passwordValues.join('') != _storePassword;
      if (_haveError) {
        _passwordValues = [];
      }
      setState(() {});
      if (!_haveError) {
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => NavigatorScreen(),
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
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(320, 568));
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: EdgeInsets.only(top: 231.h - 194.h * _move.value),
            child: Transform.scale(
              scale: _firstScaleAnimation.value +
                  _pulse.value +
                  (_move.value * -0.3),
              child: AppImages.logoHeart(),
            ),
          ),
          Positioned(
            top: 120.h,
            child: Opacity(
              opacity: _passOpacity.value,
              child: PassPoints(
                activeCount: _passwordValues.length,
                errorText: 'Пароли не совпадают',
                errorColor: AppColors.cFF3B30,
                haveError: _haveError,
                text: 'Введите пароль:',
              ),
            ),
          ),
          Positioned(
            bottom: -_passwordAnimation.value * 30.h,
            child: Opacity(
              opacity: 1 - _passwordAnimation.value,
              child: Column(
                children: [
                  SizedBox(
                    width: 240.w,
                    child: Text(
                      'Мы повышаем эффективность Вашего общения с врачом',
                      style: AppTypography.font24.copyWith(
                        color: AppColors.c000000,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 58.h, bottom: 16.h),
                    child: Text(
                      '© 2020 FORS NY Inc 1.0 (10)',
                      style: AppTypography.font10.copyWith(
                        color: AppColors.cA0B4CB,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: _passwordAnimation.value * 30.h + 40.h,
            child: Opacity(
              opacity: _passwordAnimation.value,
              child: IgnorePointer(
                ignoring: _passwordAnimation.value != 1,
                child: PassKey(
                  keys: _passwordValues,
                  haveFaceId:
                      context.bloc<AppSettingsBloc>().appSettings.useFaceId,
                  localAuthType: _biometricType,
                  onFaceIdTap: () {
                    LocalAuthentication().authenticateWithBiometrics(
                      localizedReason: 'Вход',
                    );
                  },
                  onChange: _setPassword,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
