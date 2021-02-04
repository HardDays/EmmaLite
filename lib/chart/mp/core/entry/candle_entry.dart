import 'dart:ui' as ui;

import 'package:emma_mobile/chart/mp/core/entry/entry.dart';

class CandleEntry extends Entry {
  /// shadow-high value
  double _shadowHigh = 0;

  double _shadowHigh2 = 0;

  /// shadow-low value
  double _shadowLow = 0;

  double _shadowLow2 = 0;

  /// close value
  double _close = 0;

  double _close2 = 0;

  /// open value
  double _open = 0;

  double _open2 = 0;

  bool _isMin = false; //todo мое

  bool _isMax = false;

  CandleEntry({
    double x,
    double shadowH,
    double shadowL,
    double shadowH2,
    double shadowL2,
    double open,
    double close,
    double open2,
    double close2,
    ui.Image icon,
    Object data,
    bool isMin,
    bool isMax,
  }) : super(x: x, y: (shadowH + shadowL) / 2, icon: icon, data: data) {
    _shadowHigh = shadowH;
    _shadowHigh2 = shadowH2;
    _shadowLow = shadowL;
    _shadowLow2 = shadowL2;
    _open = open;
    _open2 = open2;
    _close = close;
    _close2 = close2;
    _isMin = isMin;
    _isMax = isMax;
  }

  CandleEntry copy() {
    CandleEntry c = CandleEntry(
        x: x,
        shadowH: _shadowHigh,
        shadowL: _shadowLow,
        open: _open,
        close: _close,
        data: mData);
    return c;
  }

  bool get isMin => _isMin; //todo мое

  bool get isMax => _isMax;

  bool get isArterial =>
      _close2 != null ||
      _open2 != null ||
      _shadowLow2 != null ||
      _shadowHigh2 != null;

  double get open => _open;

  double get close => _close;

  double get shadowLow => _shadowLow;

  double get shadowHigh => _shadowHigh;

  double get open2 => _open2;

  double get close2 => _close2;

  double get shadowLow2 => _shadowLow2;

  double get shadowHigh2 => _shadowHigh2;
}
