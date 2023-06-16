import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/chart_option.dart';

abstract class OnChartOptionSelect {
  void onChartOptionSelect(ChartModel chart, ChartOption option);
}