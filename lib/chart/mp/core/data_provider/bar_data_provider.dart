

import 'package:emma_mobile/chart/mp/core/data/bar_data.dart';
import 'package:emma_mobile/chart/mp/core/data_provider/bar_line_scatter_candle_bubble_data_provider.dart';

mixin BarDataProvider implements BarLineScatterCandleBubbleDataProvider {
  BarData getBarData();

  bool isDrawBarShadowEnabled();

  bool isDrawValueAboveBarEnabled();

  bool isHighlightFullBarEnabled();
}
