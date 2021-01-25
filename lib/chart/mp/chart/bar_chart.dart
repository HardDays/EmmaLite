

import 'package:emma_mobile/chart/mp/chart/bar_line_scatter_candle_bubble_chart.dart';
import 'package:emma_mobile/chart/mp/controller/bar_chart_controller.dart';

class BarChart extends BarLineScatterCandleBubbleChart<BarChartController> {
  const BarChart(BarChartController controller) : super(controller);
}

class BarChartState extends BarLineScatterCandleBubbleState<BarChart> {}
