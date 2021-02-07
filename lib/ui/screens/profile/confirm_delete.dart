import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/ui/components/buttons/emma_border_button.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/profile/image.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  final User user;

  const ConfirmDelete({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 80.h,
          bottom: 24.h,
        ),
        child: Column(
          children: [
            SmallProfileImage(user: user),
            Padding(
              padding: EdgeInsets.only(top: 16.h, bottom: 4.h),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Center(
                  child: Text(
                    '${user.firstName} ${user.lastName}',
                    style: AppTypography.font16.copyWith(
                      color: AppColors.c3B4047,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              user.status,
              style: AppTypography.font14.copyWith(
                color: AppColors.c9B9B9B,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 56.h, bottom: 16.h),
              child: Text(
                'Вы действительно хотите удалить профиль?',
                style: AppTypography.font16.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.c3B4047,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'При этом удаляться все данные по этому человеку. И их уже нельзя будет вернуть.',
              style: AppTypography.font14.copyWith(
                color: AppColors.c9B9B9B,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: EmmaBorderButton(
                text: 'Отменить',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            EmmaFilledButton(
              title: 'Удалить',
              activeColor: AppColors.cFF3B30,
              haveShadow: false,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
