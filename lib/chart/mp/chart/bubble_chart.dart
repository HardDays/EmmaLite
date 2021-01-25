import 'package:emma_mobile/chart/mp/chart/bar_line_scatter_candle_bubble_chart.dart';
import 'package:emma_mobile/chart/mp/controller/bubble_chart_controller.dart';

class BubbleChart
    extends BarLineScatterCandleBubbleChart<BubbleChartController> {
  const BubbleChart(BubbleChartController controller) : super(controller);
}

class BubbleChartState extends BarLineScatterCandleBubbleState<BubbleChart> {}
