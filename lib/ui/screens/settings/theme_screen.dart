import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/chip.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/linear_chart.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class ThemeScreen extends StatelessWidget {
  final Function onTap;

  const ThemeScreen({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: true,
            child: Column(
              children: [
                EmmaAppBar(
                  title: 'Оформление',
                  leading: BackLeading(text: 'Настройки', onTap: onTap),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: EmmaAppBar(
                    title: 'Температура',
                    leading: BackLeading(text: 'Измерения'),
                    trailing: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: AppIcons.plus(),
                    ),
                    childUpperLine: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChipItem(title: 'День', isActive: false),
                              ChipItem(title: 'Неделя', isActive: false),
                              ChipItem(title: 'Месяц', isActive: true),
                              ChipItem(
                                title: 'Год',
                                isActive: false,
                                haveMargin: false,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 12.w,
                            right: 12.w,
                            bottom: 9.h,
                            top: 11.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Декабрь',
                                style: AppTypography.font16.copyWith(
                                  color: AppColors.cBFBFBF,
                                ),
                              ),
                              Text(
                                'Январь',
                                style: AppTypography.font16.copyWith(
                                  color: AppColors.cBFBFBF,
                                ),
                              ),
                              Text(
                                'Февраль',
                                style: AppTypography.font16.copyWith(
                                  color: AppColors.cBFBFBF,
                                ),
                              ),
                              Text(
                                'Март',
                                style: AppTypography.font16.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.c00ACE3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 250.h,
                  child: ColoredBox(
                    color: AppColors.cFFFFFF,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: LinearChart(
                        bloc: MeasurementDetailBloc(
                          measurement:
                              Temperature(date: DateTime.now().toString()),
                          isMock: true,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 56.h,
            child: SizedBox(
              height: 97.h,
              width: MediaQuery.of(context).size.width,
              child: ColoredBox(
                color: AppColors.cF5F7FA,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 138.w,
                        height: 58.h,
                        decoration: BoxDecoration(
                          color: AppColors.c00ACE3,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            'Светлая',
                            style: AppTypography.font16.copyWith(
                              color: AppColors.cFFFFFF,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 138.w,
                        height: 58.h,
                        decoration: BoxDecoration(
                          color: AppColors.c000000,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            'Темная',
                            style: AppTypography.font16.copyWith(
                              color: AppColors.cFFFFFF,
                            ),
                          ),
                        ),
                      ),
                    ],
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
