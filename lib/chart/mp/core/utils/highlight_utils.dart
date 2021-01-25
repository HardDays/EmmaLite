import 'dart:ui';

import 'package:emma_mobile/chart/mp/core/highlight/highlight.dart';
import 'package:emma_mobile/chart/mp/painter/painter.dart';


abstract class HighlightUtils {
  static Highlight performHighlight(
      ChartPainter painter, Highlight curHighlight, Highlight lastHighlight) {
    if (curHighlight == null || curHighlight.equalTo(lastHighlight)) {
      painter.highlightValue6(null, true);
      lastHighlight = null;
    } else {
      painter.highlightValue6(curHighlight, true);
      lastHighlight = curHighlight;
    }
    return lastHighlight;
  }

  static Highlight performHighlightDrag(
      ChartPainter painter, Highlight lastHighlight, Offset offset) {
    Highlight h = painter.getHighlightByTouchPoint(offset.dx, offset.dy);

    if (h != null && !h.equalTo(lastHighlight)) {
      lastHighlight = h;
      painter.highlightValue6(h, true);
    }

    return lastHighlight;
  }
}
