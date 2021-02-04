import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
import 'package:emma_mobile/chart/mp/chart/candlestick_chart.dart';
import 'package:emma_mobile/chart/mp/controller/candlestick_chart_controller.dart';
import 'package:emma_mobile/chart/mp/core/adapter_android_mp.dart';
import 'package:emma_mobile/chart/mp/core/data/candle_data.dart';
import 'package:emma_mobile/chart/mp/core/data_set/candle_data_set.dart';
import 'package:emma_mobile/chart/mp/core/entry/candle_entry.dart';
import 'package:emma_mobile/chart/mp/core/enums/axis_dependency.dart';
import 'package:emma_mobile/chart/mp/core/enums/x_axis_position.dart';
import 'package:emma_mobile/chart/mp/core/transformer/transformer.dart';
import 'package:emma_mobile/chart/mp/core/value_formatter/value_formatter.dart';
import 'package:emma_mobile/chart/mp/core/view_port.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/ui/components/measurement/linear_chart.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class PulseChart extends StatefulWidget {
  final MeasurementDetailBloc bloc;

  const PulseChart({Key key, this.bloc}) : super(key: key);

  @override
  _PulseChartState createState() => _PulseChartState();
}

class _PulseChartState extends State<PulseChart> {
  CandlestickChartController controller;

  double _min;
  double _max;

  void initController() {
    final width = MediaQuery.of(context).size.width - 55.w;
    final transformer = Transformer(
      ViewPortHandler()
        ..setChartDimens(width, 300.h)
        ..restrainViewPort(25.w, 0.h, 0, 0.h),
    );
    final List<Measurement> list = []..addAll(widget.bloc.data);
    list.sort(
      (i, j) => double.parse(i.value()).compareTo(double.parse(j.value())),
    );

    if (list.isNotEmpty) {
      _min = double.parse(list.first.value());
      _max = double.parse(list.last.value());
    } else {
      _min = 13;
      _max = 87;
    }

    final min = _min - 13;
    final max = _max + 13;
    controller = CandlestickChartController(
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
          ..spacePercentBottom = 0
          ..spacePercentTop = 0
          ..setAxisMinValue(min)
          ..setAxisMinimum(min)
          ..setAxisMaximum(max)
          ..setAxisMaxValue(max)
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
        axisRight.setAxisMaxValue(max);
        axisRight.setAxisMinValue(min);
        axisRight.setAxisMinimum(min);
        axisRight.setAxisMaximum(max);
        axisRight.textSize = Constants.textSize12;
        (controller as CandlestickChartController).setViewPortOffsets(
          0.w,
          0,
          20.w,
          0,
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
      customViewPortEnabled: true,
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

  void initData() {
    final List<Measurement> sortValues = []..addAll(widget.bloc.data);

    final type = widget.bloc.type;
    final startDate = widget.bloc.activeTimeRange.timeTo;
    sortValues.sort((i, j) => i.dateTime.compareTo(j.dateTime));
    final Set<int> days = {};
    for (int i = 0; i < sortValues.length; i++) {
      days.add(type.getCandleInt(sortValues[i].dateTime));
    }

    List<CandleEntry> values = List();
    final size = MediaQuery.of(context).size.width - 80.w;

    for (int i = 0; i < days.length; i++) {
      final list = sortValues
          .where(
            (e) => type.getCandleInt(e.dateTime) == days.toList()[i],
          )
          .toList();
      list.sort(
        (i, j) => double.parse(i.value()).compareTo(double.parse(j.value())),
      );


      final max = double.parse(list.last.value());
      final min = double.parse(list.first.value());
      final percent = widget.bloc.type.percentDate(
        list.first.dateTime,
        startDateTime: startDate,
      );
      values.add(
        CandleEntry(
          x: i.toDouble(),
          shadowH: max,
          shadowL: min,
          open: max,
          close: min,
          data: size * percent + 25.w,
          isMax: max == _max,
          isMin: min == _min,
        ),
      );
    }

    final set1 = CandleDataSet(values, 'Data Set', multiplier: 0);

    set1.setDrawIcons(false);
    set1.setAxisDependency(AxisDependency.LEFT);
    set1.setDrawValues(false);
    set1.setDecreasingColor(AppColors.c00ACE3);
    set1.setValueFormatter(CandleLabelFormatter(values));
    set1.setValueTextColor(AppColors.c00ACE3);
    set1.setValueTextSize(Constants.textSize12);
    set1.setValueTypeface(TypeFace(fontWeight: FontWeight.w500));

    controller.data = CandleData.fromList(List()..add(set1));
  }

  @override
  Widget build(BuildContext context) {
    initController();
    initData();
    return CandlestickChart(controller);
  }
}

class CandleLabelFormatter extends ValueFormatter {
  final List<CandleEntry> data;

  CandleLabelFormatter(this.data) {
  }

  @override
  String getIndexAxisLabel(int index, {bool showMax}) {
    final maxText = 'Макс.\n${data[index].open}';
    final minText = 'Мин.\n${data[index].close}';
    if (showMax != null) {
      if (showMax) {
        return maxText;
      } else {
        return minText;
      }
    }
    if (data.isEmpty) {
      return '';
    }
    if (data[index].isMax) {
      return maxText;
    }
    if (data[index].isMin) {
      return minText;
    }
    return '';
  }
}
