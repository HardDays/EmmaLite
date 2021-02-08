import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/calendar.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final markers = context.bloc<AssignBloc>().calendarMarkers();
    return Scaffold(
      body: Column(
        children: [
          const EmmaAppBar(
            title: 'Выбор даты назначения',
            leading: BackLeading(text: 'Назначения'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.cFFFFFF,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Calendar(
                width: 288.w,
                height: 300.h,
                titleStyle: AppTypography.font18.copyWith(
                  color: AppColors.c4A4A4A,
                  fontWeight: FontWeight.w700,
                ),
                weekdayTextStyle: AppTypography.font14.copyWith(
                  color: AppColors.c4A4A4A,
                ),
                todayTextStyle: AppTypography.font14.copyWith(
                  color: AppColors.c00ACE3,
                ),
                outThisMonthStyle: AppTypography.font14.copyWith(
                  color: AppColors.c4A4A4A.withOpacity(0.3),
                ),
                defaultDaysTextStyle: AppTypography.font14.copyWith(
                  color: AppColors.c4A4A4A,
                ),
                markedDates: markers,
              ),
            ),
          )
        ],
      ),
    );
  }
}
