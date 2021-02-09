import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/measurement/select_measurement.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmptyMeasurements extends StatelessWidget {
  const EmptyMeasurements({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 72.h),
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.cFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: AppColors.c0D000000,
                  offset: Offset(0, 3),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            width: 120.w,
            height: 120.w,
            child: Center(
              child: AppIcons.measurementsInactive(width: 44.w, height: 44.w),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: SizedBox(
              width: 256.w,
              child: Text(
                'Здесь будут показываться ваши последние значения по всем измерениям',
                style: AppTypography.font14.copyWith(color: AppColors.c9B9B9B),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 55.h),
            child: EmmaFilledButton(
              width: 256.w,
              title: 'Добавить первое измерение',
              fontSize: Constants.textSize14,
              onTap: () => navigatorPush(context, SelectMeasurement()),
            ),
          )
        ],
      ),
    );
  }
}
