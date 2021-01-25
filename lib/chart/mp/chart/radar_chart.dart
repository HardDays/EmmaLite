import 'package:emma_mobile/chart/mp/chart/pie_radar_chart.dart';
import 'package:emma_mobile/chart/mp/controller/radar_chart_controller.dart';

class RadarChart extends PieRadarChart<RadarChartController> {
  const RadarChart(RadarChartController controller) : super(controller);
}

class RadarChartState extends PieRadarChartState<RadarChart> {}
