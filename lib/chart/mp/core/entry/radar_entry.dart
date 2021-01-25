
import 'dart:ui' as ui;

import 'package:emma_mobile/chart/mp/core/entry/entry.dart';

class RadarEntry extends Entry {
  RadarEntry({double value, Object data, ui.Image icon})
      : super(x: 0, y: value, icon: icon, data: data);

  /// This is the same as getY(). Returns the value of the RadarEntry.
  ///
  /// @return
  double getValue() {
    return y;
  }

  RadarEntry copy() {
    RadarEntry e = RadarEntry(value: y, data: mData);
    return e;
  }
}
