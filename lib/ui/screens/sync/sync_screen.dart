import 'dart:io';

import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/app_bar/small_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/buttons/emma_flat_button.dart';
import 'package:emma_mobile/ui/screens/sync/sync_cancel_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SyncScreen extends StatelessWidget {
  final bool hasBack;
  final bool hasCancel;
  final String title;
  final String text;
  final String buttonTitle;
  final Function onNext;

  SyncScreen({
    Key key,
    this.hasBack = true,
    this.hasCancel = false,
    this.title = '',
    this.text,
    this.buttonTitle = '',
    this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hasBack
                ? SmallAppBar(
                    title: '',
                    leading: BackLeading(text: 'Назад'),
                  )
                : SizedBox(
                    height: 75.h,
                  ),
            Padding(
              padding: EdgeInsets.only(top: 120.h),
              child: SvgPicture.asset(
                Platform.isAndroid
                    ? 'assets/icons/google.svg'
                    : 'assets/icons/apple.svg',
              ),
            ),
            const Spacer(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.font16.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.c3B4047,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: AppTypography.font14.copyWith(
                  color: AppColors.c3B4047,
                ),
              ),
            ),
            const Spacer(),
            EmmaFilledButton(
              width: 288.w,
              title: buttonTitle,
              fontSize: Constants.textSize17,
              onTap: onNext,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: EmmaFlatButton(
                title: hasCancel ? 'Сделаю позже в Настройках' : '',
                onTap: () {
                  if (hasCancel) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SyncCancelScreen(),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
