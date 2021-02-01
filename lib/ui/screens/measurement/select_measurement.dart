import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_list_item.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectMeasurement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final date = DateTime.now().toString();
    List<Measurement> data = [
      ArterialPressure(date: date),
      HeightModel(date: date),
      Pulse(date: date),
      BloodSugar(date: date),
      Temperature(date: date),
    ];
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body: Column(
        children: [
          EmmaAppBar(
            title: 'Выберите показатель',
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, top: 5.h, right: 16.w),
                child: Row(
                  children: [
                    AppIcons.chevronLeft(),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Text(
                        'Назад',
                        style: AppTypography.font14.copyWith(
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
            child: ListView.separated(
              itemCount: data.length,
              padding: EdgeInsets.only(top: 14.h),
              itemBuilder: (_, i) {
                return MeasurementListItem(
                  isSelectScreen: true,
                  item: data[i],
                );
              },
              separatorBuilder: (_, __) {
                return Padding(padding: EdgeInsets.only(top: 8.h));
              },
            ),
          ),
        ],
      ),
    );
  }
}
