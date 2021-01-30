import 'dart:math';

import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_state.dart';
import 'package:emma_mobile/chart/mp/chart/line_chart.dart';
import 'package:emma_mobile/chart/mp/controller/line_chart_controller.dart';
import 'package:emma_mobile/chart/mp/core/adapter_android_mp.dart';
import 'package:emma_mobile/chart/mp/core/data/line_data.dart';
import 'package:emma_mobile/chart/mp/core/data_set/line_data_set.dart';
import 'package:emma_mobile/chart/mp/core/entry/entry.dart';
import 'package:emma_mobile/chart/mp/core/enums/mode.dart';
import 'package:emma_mobile/chart/mp/core/enums/x_axis_position.dart';
import 'package:emma_mobile/chart/mp/core/transformer/transformer.dart';
import 'package:emma_mobile/chart/mp/core/value_formatter/value_formatter.dart';
import 'package:emma_mobile/chart/mp/core/view_port.dart';
import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement_app_bar.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_history_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementDetailScreen extends StatefulWidget {
  final Measurement item;

  const MeasurementDetailScreen({
    @required this.item,
    Key key,
  }) : super(key: key);

  @override
  _MeasurementDetailScreenState createState() =>
      _MeasurementDetailScreenState();
}

class ValueLabelFormatter extends ValueFormatter {
  final List<double> values;

  ValueLabelFormatter(this.values) {
    if (values.isEmpty) return;
    final values2 = []..addAll(values.where((element) => e != null));
    values2.sort((i, j) => i.compareTo(j));
    min = values2.first;
    max = values2.last;
  }

  num min;
  num max;

  @override
  String getIndexAxisLabel(int index) {
    if (values.isEmpty) return '';
    if (values[index] == max) {
      return 'Макс.\n${values[index]}';
    }
    if (values[index] == min) {
      return 'Мин.\n${values[index]}';
    }
    return '';
  }

  @override
  bool isMax(int index) {
    if (values.isEmpty) return false;
    return values[index] == max;
  }

  @override
  bool isMin(int index) {
    if (values.isEmpty) return false;
    return values[index] == min;
  }

  @override
  bool isOther(int index) {
    if (values.isEmpty) return false;
    return isMin(index) ? false : true;
  }

  @override
  String getAxisLabel(double value, x) {
    return value.toString();
  }
}

class TitleLabelFormatter extends ValueFormatter {
  final List<String> values;

  TitleLabelFormatter(this.values);

  @override
  String getIndexAxisLabel(int index) {
    return values[index];
  }
}

class _MeasurementDetailScreenState extends State<MeasurementDetailScreen> {
  LineChartController controller;

  void initController(MeasurementDetailBloc bloc) {
    final width = MediaQuery.of(context).size.width - 55.w;
    final transformer = Transformer(
      ViewPortHandler()
        ..setChartDimens(width, 330.h)
        ..restrainViewPort(25.w, 0, 0, 20.w),
    );
    controller = LineChartController(
      axisLeftSettingFunction: (axisLeft, controller) {
        axisLeft
          ..enabled = true
          ..textColor = (Colors.transparent)
          ..textSize = 0
          ..setDrawZeroLine(false)
          ..setStartAtZero(false)
          ..setLabelCount2(10, false)
          ..gridColor = Colors.transparent
          ..zeroLineColor = Colors.transparent
          ..spacePercentBottom = 15
          ..spacePercentTop = 10
          ..axisLineColor = AppColors.cE1E4E9;
      },
      axisRightSettingFunction: (axisRight, controller) {
        axisRight.enabled = true;
        axisRight.drawZeroLine = false;
        axisRight.setStartAtZero(false);
        axisRight.axisLineColor = AppColors.cE1E4E9;
        axisRight.drawGridLines = true;
        axisRight.gridColor = AppColors.cE1E4E9;
        axisRight.textColor = AppColors.c9B9B9B;
        axisRight.textSize = Constants.textSize12;
        (controller as LineChartController).setViewPortOffsets(
          5.w,
          0,
          20.w,
          5.h,
        );
      },
      legendSettingFunction: (legend, controller) {
        legend.enabled = false;
      },
      xAxisSettingFunction: (xAxis, controller) {
        xAxis
          ..axisLineColor = (Colors.transparent)
          ..gridColor = AppColors.cA0B4CB
          ..position = XAxisPosition.BOTTOM
          ..textColor = AppColors.c9B9B9B
          ..textSize = 16.h
          ..avoidFirstLastClipping = false
          ..setLabelCount2(
            bloc.type.numbers(timeFrom: bloc.activeTimeRange.timeFrom).length,
            true,
          )
          ..setValueFormatter(
            TitleLabelFormatter(
              bloc.type.numbers(timeFrom: bloc.activeTimeRange.timeFrom),
            ),
          )
          ..enableGridDashedLine(1, 2, 0);
      },
      drawGridBackground: false,
      dragXEnabled: false,
      dragYEnabled: true,
      scaleXEnabled: false,
      clipValuesToContent: false,
      leftAxisTransformer: transformer,
      resolveGestureVerticalConflict: true,
      scaleYEnabled: true,
      pinchZoomEnabled: false,
      drawMarkers: false,
      backgroundColor: Colors.white,
    );
  }

  List<Entry> values = [];

  void initValues(MeasurementDetailBloc bloc) {
    values = [];
    final List<Measurement> sortValues = []..addAll(bloc.data);
    final startDate = bloc.activeTimeRange.timeTo;
    sortValues.sort((i, j) => i.dateTime.compareTo(j.dateTime));
    final size = MediaQuery.of(context).size.width - 80.w;

    for (int i = 0; i < bloc.data.length; i++) {
      final item = sortValues[i];
      final value = double.parse(item.value());
      final percent = bloc.type.percentDate(
        item.dateTime,
        startDateTime: startDate,
      );
      values.add(
        Entry(x: i.toDouble(), y: value, data: size * percent + 25.w),
      );
    }
  }

  void initData() {
    LineDataSet set1;
    final List<Entry> v = [];
    if (values.isEmpty) {
      v.add(Entry(x: 0.0, y: 0.0, data: 0.0));
      v.add(Entry(x: 0.0, y: 100.0, data: 10.0));
    }
    set1 = LineDataSet(values.isEmpty ? v : values, '');

    set1.setMode(Mode.LINEAR);
    set1.setDrawFilled(true);
    set1.setCircleHoleColor(AppColors.cFFFFFF);
    set1.setCircleHoleRadius(3.w);
    set1.setCircleRadius(5.w);
    set1.setValueTextSize(10);
    set1.setLineWidth(2.w);
    set1.setDrawHighlightIndicators(false);
    set1.setFillColor(Colors.white);
    set1.setCircleColor(AppColors.c00ACE3);
    set1.setDrawCircles(true);
    set1.setColor1(AppColors.c00ACE3);
    set1.setDrawValues(true);
    set1.setDrawHorizontalHighlightIndicator(false);
    set1.setValueFormatter(
      ValueLabelFormatter(values.map((e) => e.y).toList()),
    );
    set1.setValueTextColor(AppColors.c00ACE3);
    set1.setValueTextSize(Constants.textSize12);
    set1.setValueTypeface(TypeFace(fontWeight: FontWeight.w500));
    set1.setStartPaintIndex = values.isEmpty ? 2 : 0;
    controller.data = LineData.fromList(List()..add(set1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MeasurementDetailBloc(measurement: widget.item),
      child: Scaffold(
        backgroundColor: AppColors.cF5F7FA,
        body: Builder(
          builder: (context) {
            final bloc = context.bloc<MeasurementDetailBloc>();
            return BlocBuilder<MeasurementDetailBloc, MeasurementDetailState>(
              builder: (_, __) {
                final type = bloc.item;
                final renderLinearChart =
                    type is HeightModel || type is Temperature || type is BloodSugar;
                if (renderLinearChart) {
                  initValues(bloc);
                  initController(bloc);
                  initData();
                }
                return Column(
                  children: [
                    MeasurementDetailAppBar(
                      title: widget.item.longTitle,
                      initialType: bloc.type,
                      item: widget.item,
                      onChange: bloc.setDateType,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400.h,
                      color: AppColors.cFFFFFF,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 15.w),
                              child: renderLinearChart
                                  ? Stack(
                                      children: [
                                        LineChart(controller),
                                        if (bloc.data.isEmpty)
                                          _EmptyChartDataPlaceholder(),
                                      ],
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40.h),
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
                                  if (renderLinearChart)
                                    Padding(
                                      padding: EdgeInsets.only(right: 16.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            bloc.type.leftFormatter(
                                                timeFrom: bloc
                                                    .activeTimeRange.timeFrom),
                                            style:
                                                AppTypography.font12.copyWith(
                                              color: AppColors.c9B9B9B,
                                            ),
                                          ),
                                          Text(
                                            bloc.type.rightFormatter(
                                                timeTo: bloc
                                                    .activeTimeRange.timeTo),
                                            style:
                                                AppTypography.font12.copyWith(
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
                                          title: 'Мин.',
                                          subtitle:
                                              '${bloc.item is ArterialPressure ? '\n' : ''} ${bloc.min}',
                                        ),
                                      ),
                                      Expanded(
                                        child: _ColumnItem(
                                          title: 'Макс.',
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
          text: '$subtitle ${subtitle.isEmpty ? '' : bloc.item.units}',
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
