

import 'package:emma_mobile/chart/mp/core/data/bar_line_scatter_candle_bubble_data.dart';
import 'package:emma_mobile/chart/mp/core/data_provider/chart_interface.dart';
import 'package:emma_mobile/chart/mp/core/enums/axis_dependency.dart';
import 'package:emma_mobile/chart/mp/core/transformer/transformer.dart';

mixin BarLineScatterCandleBubbleDataProvider implements ChartInterface {
  Transformer getTransformer(AxisDependency axis);

  bool isInverted(AxisDependency axis);

  double getLowestVisibleX();

  double getHighestVisibleX();

  BarLineScatterCandleBubbleData getData();
}
