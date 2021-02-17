import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/ui/components/buttons/emma_border_button.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/images.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmCreate extends StatelessWidget {
  final User user;

  const ConfirmCreate({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 49.h, bottom: 20.h),
              child: AppImages.agreement(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: Text(
                'consentToTheProcessingOfPersonalDataMainLabelTitle'.tr,
                style: AppTypography.font16.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.c3B4047,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            EmmaFilledButton(
              title: 'confirmMyConsentButtonTitle'.tr,
              height: 50.h,
              width: 288.w,
              onTap: () {
                context.bloc<ProfileCubit>().addUser(user);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
              child: EmmaBorderButton(
                color: Colors.white,
                text: 'decline'.tr,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
