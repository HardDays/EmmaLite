import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_state.dart';
import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/arterial_chart.dart';
import 'package:emma_mobile/ui/components/measurement/linear_chart.dart';
import 'package:emma_mobile/ui/components/measurement/pulse_chart.dart';
import 'package:emma_mobile/ui/components/measurement_app_bar.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_history_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementDetailScreen extends StatelessWidget {
  final Measurement item;

  const MeasurementDetailScreen({
    @required this.item,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MeasurementDetailBloc(measurement: item),
      child: Scaffold(
        backgroundColor: AppColors.cF5F7FA,
        body: Builder(
          builder: (context) {
            final bloc = context.bloc<MeasurementDetailBloc>();
            return BlocBuilder<MeasurementDetailBloc, MeasurementDetailState>(
              builder: (_, __) {
                final type = bloc.item;
                final renderLinearChart = type is HeightModel ||
                    type is Temperature ||
                    type is BloodSugar;
                return Column(
                  children: [
                    MeasurementDetailAppBar(
                      title: item.longTitle.tr,
                      initialType: bloc.type,
                      item: item,
                      onChange: bloc.setDateType,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: type is ArterialPressure ? 333.h : 300.h,
                      color: AppColors.cFFFFFF,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 15.w),
                              child: Stack(
                                children: [
                                  if (renderLinearChart || bloc.data.isEmpty)
                                    LinearChart(bloc: bloc)
                                  else if (type is Pulse)
                                    PulseChart(bloc: bloc)
                                  else
                                    ArterialChart(bloc: bloc),
                                  if (bloc.data.isEmpty)
                                    _EmptyChartDataPlaceholder(),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30.h),
                          ),
                          if (bloc.data.isEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                left: 11.w,
                                bottom: 16.h,
                              ),
                              child: Text(
                                'Нет данных',
                                style: AppTypography.font18.copyWith(
                                  color: AppColors.c9B9B9B,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8.w,
                                bottom: 16.h,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 16.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          bloc.type.leftFormatter(
                                            timeFrom:
                                                bloc.activeTimeRange.timeFrom,
                                          ),
                                          style: AppTypography.font12.copyWith(
                                            color: AppColors.c9B9B9B,
                                          ),
                                        ),
                                        Text(
                                          bloc.type.rightFormatter(
                                            timeTo: bloc.activeTimeRange.timeTo,
                                          ),
                                          style: AppTypography.font12.copyWith(
                                            color: AppColors.c9B9B9B,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _ColumnItem(
                                          title: '${'minLabelTextco'.tr}.',
                                          subtitle:
                                              '${bloc.item is ArterialPressure ? '\n' : ''} ${bloc.min}',
                                        ),
                                      ),
                                      Expanded(
                                        child: _ColumnItem(
                                          title: '${'maxLabelTextco'.tr}.',
                                          subtitle:
                                              '${bloc.item is ArterialPressure ? '\n' : ''} ${bloc.max}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                    _History(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _EmptyChartDataPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.cE1E4E9,
              width: 1.w,
            ),
          ),
          child: Center(
            child: AppIcons.measurementsInactive(
              width: 32.w,
              height: 32.w,
            ),
          ),
        ),
      ),
    );
  }
}

class _ColumnItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ColumnItem({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<MeasurementDetailBloc>();
    return RichText(
      maxLines: 2,
      text: TextSpan(children: [
        TextSpan(
          text: '$title:',
          style: AppTypography.font14.copyWith(
            color: AppColors.c3B4047,
            fontWeight: FontWeight.w300,
          ),
        ),
        TextSpan(
          text: '$subtitle ${subtitle.isEmpty ? '' : bloc.item.units.tr}',
          style: AppTypography.font17.copyWith(
            color: AppColors.c3B4047,
            fontWeight: FontWeight.w700,
          ),
        ),
      ]),
    );
  }
}

class _History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: AppColors.cF5F7FA,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
              top: 17.h,
              left: 16.w,
              right: 16.w,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      final bloc = context.bloc<MeasurementDetailBloc>();
                      return BlocProvider.value(
                        value: bloc,
                        child: MeasurementHistoryScreen(),
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: 288.w,
                constraints: BoxConstraints(
                  minHeight: 46.h,
                ),
                color: AppColors.cFFFFFF,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'История измерений',
                        style: AppTypography.font16.copyWith(
                          color: AppColors.c3B4047,
                        ),
                      ),
                      const Spacer(),
                      AppIcons.arrowRight(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
