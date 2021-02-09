import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/screens/sync/sync_start_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class FirstBiometryScreen extends StatelessWidget {
  final BiometricType type;

  const FirstBiometryScreen({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Column(
        children: [
          const Spacer(),
          AppIcons.touchId(size: 100.w),
          Padding(
            padding: EdgeInsets.only(top: 56.h, bottom: 16.h),
            child: Text(
              'Хотите использовать ${type == BiometricType.fingerprint ? 'Touch' : 'Face'} ID?',
              style: AppTypography.font16.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 250.w,
            child: Text(
              'Это позволит входить\nв приложение без пароля.',
              style: AppTypography.font16.copyWith(
                color: AppColors.c3B4047,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 80.h,
              bottom: 12.h,
              left: 16.w,
              right: 16.w,
            ),
            child: EmmaFilledButton(
              title: 'Да, использовать ${type == BiometricType.fingerprint ? 'Touch' : 'Face'} ID',
              onTap: () {
                context.bloc<AppSettingsBloc>().setUseFaceId(true);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => SyncStartScreen(),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => SyncStartScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              child: Text(
                'Позже',
                style: AppTypography.font14.copyWith(
                  color: AppColors.c00ACE3,
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.h)),
        ],
      ),
    );
  }
}
