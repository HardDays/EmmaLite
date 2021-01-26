import 'package:flutter/rendering.dart';
import 'package:emma_mobile/chart/mp/core/animator.dart';
import 'package:emma_mobile/chart/mp/core/axis/x_axis.dart';
import 'package:emma_mobile/chart/mp/core/axis/y_axis.dart';
import 'package:emma_mobile/chart/mp/core/chart_trans_listener.dart';
import 'package:emma_mobile/chart/mp/core/common_interfaces.dart';
import 'package:emma_mobile/chart/mp/core/data/bubble_data.dart';
import 'package:emma_mobile/chart/mp/core/data_provider/bubble_data_provider.dart';
import 'package:emma_mobile/chart/mp/core/description.dart';
import 'package:emma_mobile/chart/mp/core/functions.dart';
import 'package:emma_mobile/chart/mp/core/legend/legend.dart';
import 'package:emma_mobile/chart/mp/core/marker/i_marker.dart';
import 'package:emma_mobile/chart/mp/core/render/bubble_chart_renderer.dart';
import 'package:emma_mobile/chart/mp/core/render/legend_renderer.dart';
import 'package:emma_mobile/chart/mp/core/render/x_axis_renderer.dart';
import 'package:emma_mobile/chart/mp/core/render/y_axis_renderer.dart';
import 'package:emma_mobile/chart/mp/core/transformer/transformer.dart';
import 'package:emma_mobile/chart/mp/core/view_port.dart';
import 'package:emma_mobile/chart/mp/painter/bar_line_chart_painter.dart';

class BubbleChartPainter extends BarLineChartBasePainter<BubbleData>
    implements BubbleDataProvider {
  BubbleChartPainter(
      BubbleData data,
      Animator animator,
      ViewPortHandler viewPortHandler,
      double maxHighlightDistance,
      bool highLightPerTapEnabled,
      double extraLeftOffset,
      double extraTopOffset,
      double extraRightOffset,
      double extraBottomOffset,
      IMarker marker,
      Description desc,
      bool drawMarkers,
      Color infoBgColor,
      TextPainter infoPainter,
      TextPainter descPainter,
      XAxis xAxis,
      Legend legend,
      LegendRenderer legendRenderer,
      DataRendererSettingFunction rendererSettingFunction,
      OnChartValueSelectedListener selectedListener,
      int maxVisibleCount,
      bool autoScaleMinMaxEnabled,
      bool pinchZoomEnabled,
      bool doubleTapToZoomEnabled,
      bool highlightPerDragEnabled,
      bool dragXEnabled,
      bool dragYEnabled,
      bool scaleXEnabled,
      bool scaleYEnabled,
      Paint gridBackgroundPaint,
      Paint backgroundPaint,
      Paint borderPaint,
      bool drawGridBackground,
      bool drawBorders,
      bool clipValuesToContent,
      double minOffset,
      bool keepPositionOnRotation,
      OnDrawListener drawListener,
      YAxis axisLeft,
      YAxis axisRight,
      YAxisRenderer axisRendererLeft,
      YAxisRenderer axisRendererRight,
      Transformer leftAxisTransformer,
      Transformer rightAxisTransformer,
      XAxisRenderer xAxisRenderer,
      Matrix4 zoomMatrixBuffer,
      bool customViewPortEnabled,
      ChartTransListener chartTransListener)
      : super(
            data,
            animator,
            viewPortHandler,
            maxHighlightDistance,
            highLightPerTapEnabled,
            extraLeftOffset,
            extraTopOffset,
            extraRightOffset,
            extraBottomOffset,
            marker,
            desc,
            drawMarkers,
            infoBgColor,
            infoPainter,
            descPainter,
            xAxis,
            legend,
            legendRenderer,
            rendererSettingFunction,
            selectedListener,
            maxVisibleCount,
            autoScaleMinMaxEnabled,
            pinchZoomEnabled,
            doubleTapToZoomEnabled,
            highlightPerDragEnabled,
            dragXEnabled,
            dragYEnabled,
            scaleXEnabled,
            scaleYEnabled,
            gridBackgroundPaint,
            borderPaint,
            drawGridBackground,
            drawBorders,
            clipValuesToContent,
            minOffset,
            keepPositionOnRotation,
            drawListener,
            axisLeft,
            axisRight,
            axisRendererLeft,
            axisRendererRight,
            leftAxisTransformer,
            rightAxisTransformer,
            xAxisRenderer,
            zoomMatrixBuffer,
            customViewPortEnabled,
            backgroundPaint,
            chartTransListener);

  @override
  void initDefaultWithData() {
    super.initDefaultWithData();
    renderer = BubbleChartRenderer(this, animator, viewPortHandler);
  }

  @override
  BubbleData getBubbleData() {
    return getData();
  }
}