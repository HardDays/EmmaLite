import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/images.dart';
import 'package:emma_mobile/ui/screens/first_open_screens/create_profile.dart';
import 'package:emma_mobile/ui/screens/first_open_screens/secure_data_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class FirstOpenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: AppImages.welcome(),
            ),
            Text(
              'getAcquaintedTitle'.tr,
              style: AppTypography.font16.copyWith(
                color: AppColors.c3B4047,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 16.h,
                bottom: 32.h,
              ),
              child: Text(
                'fillOutYourProfileTitle'.tr,
                style: AppTypography.font14.copyWith(
                  color: AppColors.c3B4047,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            EmmaFilledButton(
              title: 'fillOutYourProfileButtonTitle'.tr,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => FirstOpenCreateScreen(),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => SecureDataScreen(),
                    ),
                  );
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.w,
                    horizontal: 16.w,
                  ),
                  child: Text(
                    'later'.tr,
                    style: AppTypography.font14.copyWith(
                      color: AppColors.c00ACE3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
