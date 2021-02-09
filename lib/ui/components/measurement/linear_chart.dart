import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
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
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class LinearChart extends StatefulWidget {
  final MeasurementDetailBloc bloc;

  const LinearChart({Key key, this.bloc}) : super(key: key);

  @override
  _LinearChartState createState() => _LinearChartState();
}

class _LinearChartState extends State<LinearChart> {
  LineChartController controller;

  void initController() {
    final width = MediaQuery.of(context).size.width - 55.w;
    final transformer = Transformer(
      ViewPortHandler()
        ..setChartDimens(width, 230.h)
        ..restrainViewPort(25.w, 0, 0, 10.h),
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
            widget.bloc.type
                .numbers(
                  timeFrom: widget.bloc.activeTimeRange.timeFrom,
                )
                .length,
            true,
          )
          ..setValueFormatter(
            TitleLabelFormatter(
              widget.bloc.type.numbers(
                timeFrom: widget.bloc.activeTimeRange.timeFrom,
              ),
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
      highLightPerTapEnabled: false,
      highlightPerDragEnabled: false,
      backgroundColor: Colors.white,
    );
  }

  List<Entry> values = [];

  void initValues() {
    values = [];
    final List<Measurement> sortValues = []..addAll(widget.bloc.data);
    final startDate = widget.bloc.activeTimeRange.timeTo;
    sortValues.sort((i, j) => i.dateTime.compareTo(j.dateTime));
    final size = MediaQuery.of(context).size.width - 80.w;

    for (int i = 0; i < widget.bloc.data.length; i++) {
      final item = sortValues[i];
      final value = double.parse(item.value());
      final percent = widget.bloc.type.percentDate(
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
    set1 = LineDataSet(values.isEmpty ? v : values, '', multiplier: 0.03);

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
    initController();
    initValues();
    initData();
    return LineChart(controller);
  }
}

class ValueLabelFormatter extends ValueFormatter {
  final List<double> values;

  ValueLabelFormatter(this.values) {
    if (values.isEmpty) return;
    final values2 = []..addAll(values.where((e) => e != null));
    values2.sort((i, j) => i.compareTo(j));
    print(values2);
    min = values2.first;
    max = values2.last;
  }

  num min;
  num max;

  @override
  String getIndexAxisLabel(int index) {
    if (values.isEmpty) {
      return '';
    }
    if (values[index] == max) {
      return 'Макс.\n${values[index].toStringAsFixed(1)}';
    }
    if (values[index] == min) {
      return 'Мин.\n${values[index].toStringAsFixed(1)}';
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
