import 'package:emma_mobile/chart/mp/chart/pie_radar_chart.dart';
import 'package:emma_mobile/chart/mp/controller/pie_chart_controller.dart';

class PieChart extends PieRadarChart<PieChartController> {
  const PieChart(PieChartController controller) : super(controller);
}

class PieChartState extends PieRadarChartState<PieChart> {}
