import 'package:emma_mobile/ui/components/password/pass_keyboard.dart';
import 'package:emma_mobile/ui/components/password/pass_points.dart';
import 'package:emma_mobile/ui/images.dart';
import 'package:emma_mobile/ui/screens/first_open_screens/confirm_password.dart';
import 'package:emma_mobile/ui/screens/navigator_screen.dart';
import 'package:emma_mobile/ui/screens/sync/sync_start_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class CreatePasswordScreen extends StatefulWidget {
  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  List<int> _password = [];

  void _setPassword(List<int> v) {
    _password = v;
    setState(() {});
    if (_password.length == 4) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ConfirmPasswordScreen(password: _password),
            ),
          );
        },
      );
    } else {}
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
            text: 'Придумайте пароль,\nчтобы защитить свои данные:',
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
                  'laterButtonText'.tr,
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
