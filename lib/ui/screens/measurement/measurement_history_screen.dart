import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_state.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement_app_bar.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<MeasurementDetailBloc>();
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body:  BlocBuilder<MeasurementDetailBloc, MeasurementDetailState>(
          builder: (_, state) {
          return Column(
            children: [
              MeasurementDetailAppBar(
                title: 'История измерений',
                arrowText: bloc.item.title,
                showHour: bloc.item is Pulse,
                initialType: bloc.type,
                onChange: bloc.setDateType,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: bloc.data.length,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  itemBuilder: (_, i) {
                    return _Item(measurement: bloc.data[i]);
                  },
                  separatorBuilder: (_, __) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8.h),
                    );
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final Measurement measurement;

  const _Item({Key key, this.measurement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 68.h,
        ),
        color: AppColors.cFFFFFF,
        child: Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: AppIcons.measurementDefault(
                  width: 44.h,
                  height: 44.h,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${measurement.value()} ${measurement.units}',
                    style: AppTypography.font16.copyWith(
                      color: AppColors.c3B4047,
                    ),
                  ),
                  Text(
                    // ignore: lines_longer_than_80_chars
                    '${measurement.getFormattedDate(showTimeIfToday: true)}, ручной ввод',
                    style: AppTypography.font12.copyWith(
                      color: AppColors.c9B9B9B,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
