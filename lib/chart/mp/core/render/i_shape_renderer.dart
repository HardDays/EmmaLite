import 'dart:ui';

import 'package:emma_mobile/chart/mp/core/data_interfaces/i_scatter_data_set.dart';
import 'package:emma_mobile/chart/mp/core/view_port.dart';
import 'package:flutter/painting.dart';

mixin IShapeRenderer {
  /// Renders the provided ScatterDataSet with a shape.
  ///
  /// @param c               Canvas object for drawing the shape
  /// @param dataSet         The DataSet to be drawn
  /// @param viewPortHandler Contains information about the current state of the view
  /// @param posX            Position to draw the shape at
  /// @param posY            Position to draw the shape at
  /// @param renderPaint     Paint object used for styling and drawing
  void renderShape(
      Canvas c,
      IScatterDataSet dataSet,
      ViewPortHandler viewPortHandler,
      double posX,
      double posY,
      Paint renderPaint);
}
