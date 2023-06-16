import 'package:decide/authentication/controller/session_controller.dart';
import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/chart_option.dart';
import 'package:decide/tabs/repository/map/chart_map_repository.dart';

class CreateChartController {
  final ChartMapRepository _chartsRepository;
  final SessionController _sessionController;

  CreateChartController(this._chartsRepository, this._sessionController);

  String? create(String titleText, String firstMedia, String secondMedia,
      bool allowComments) {
    var currentProfile = _sessionController.currentProfile;
    if (currentProfile == null) return "Você não está logado";
    var nextId = _chartsRepository.getNextId();
    final model = ChartModel(
        id: nextId,
        owner: currentProfile,
        title: titleText,
        allowComments: allowComments,
        option1: ChartOption(id: 0, picture: firstMedia),
        option2: ChartOption(id: 1, picture: secondMedia));
    final success = _chartsRepository.insert(nextId, model);
    if(!success) return "Não foi possível inserir";
    return null;
  }
}
