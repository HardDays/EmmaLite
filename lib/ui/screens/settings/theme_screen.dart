import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/bloc/app_settings/app_settings_state.dart';
import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/chip.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/linear_chart.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeScreen extends StatelessWidget {
  final Function onTap;

  const ThemeScreen({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AppSettingsBloc>();
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (_, __) {
        return Scaffold(
          backgroundColor: AppColors.cF5F7FA,
          body: Stack(
            children: [
              Column(
                children: [
                  EmmaAppBar(
                    title: 'themeCellTitle'.tr,
                    leading: BackLeading(
                      text: 'mainSettingsTitle'.tr,
                      onTap: onTap,
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: EmmaAppBar(
                        title: 'temperature'.tr,
                        leading: BackLeading(text: 'mainTitleMeasurements'.tr),
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
                                  ChipItem(
                                      title: 'daysText_1'.tr.capitalizeFirst,
                                      isActive: false),
                                  ChipItem(
                                      title: 'selectSectionWeekTitleco'.tr,
                                      isActive: false),
                                  ChipItem(
                                      title: 'selectSectionMonthTitleco'.tr,
                                      isActive: true),
                                  ChipItem(
                                    title: 'selectSectionYearTitleco'.tr,
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
                          GestureDetector(
                            onTap: () {
                              context
                                  .bloc<AppSettingsBloc>()
                                  .setTheme(ThemeMode.light);
                            },
                            child: Container(
                              width: 138.w,
                              height: 58.h,
                              decoration: BoxDecoration(
                                color: AppColors.c00ACE3,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  'brightThemeCellTitle'.tr,
                                  style: AppTypography.font16.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .bloc<AppSettingsBloc>()
                                  .setTheme(ThemeMode.dark);
                            },
                            child: Container(
                              width: 138.w,
                              height: 58.h,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  'darkThemeCellTitle'.tr,
                                  style: AppTypography.font16.copyWith(
                                    color: Colors.white,
                                  ),
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
    );
  }
}
