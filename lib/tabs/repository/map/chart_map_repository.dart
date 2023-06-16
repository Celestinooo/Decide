import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:decide/tabs/repository/map/map_repository.dart';

class ChartMapRepository extends MapRepository<ChartModel, int> {

  List<ChartModel> getChartsByOwner(ProfileModel owner){
    final charts = getAll();
    final returnCharts = <ChartModel>[];
    for (var chart in charts) {
      if(chart.owner.login != owner.login) continue;
      returnCharts.add(chart);
    }
    return returnCharts;
  }

  int getNextId(){
    var all = getAll();
    return all.isEmpty ? 0 : all.last.id+1;
  }
}
