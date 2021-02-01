import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/fonts.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          EmmaAppBar(
            title: 'Выбор даты назначения',
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 18.w,
                  top: 13.h,
                  right: 16.w,
                  bottom: 12.h,
                ),
                child: Row(
                  children: [
                    AppIcons.chevronLeft(),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Text(
                        'Назначения',
                        style: AppTypography.font12.copyWith(
                          color: AppColors.c00ACE3,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: SizedBox(
                  width: 288.w,
                  child: Center(
                    child: Text('Календарь в разработке'),
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
