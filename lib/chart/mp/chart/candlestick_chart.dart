import 'package:emma_mobile/chart/mp/chart/bar_line_scatter_candle_bubble_chart.dart';
import 'package:emma_mobile/chart/mp/controller/candlestick_chart_controller.dart';

class CandlestickChart
    extends BarLineScatterCandleBubbleChart<CandlestickChartController> {
  const CandlestickChart(CandlestickChartController controller)
      : super(controller);
}

class CandlestickChartState
    extends BarLineScatterCandleBubbleState<CandlestickChart> {}
