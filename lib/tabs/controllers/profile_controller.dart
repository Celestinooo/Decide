import 'package:decide/authentication/controller/session_controller.dart';
import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/follow_model.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:decide/tabs/repository/map/chart_map_repository.dart';
import 'package:decide/tabs/repository/map/follow_map_repository.dart';
import 'package:decide/tabs/repository/map/profile_map_repository.dart';

class ProfileController {
  final ProfileMapRepository _repository;
  final ChartMapRepository _chartsRepository;
  final SessionController _sessionController;
  final FollowMapRepository _followMapRepository;

  ProfileController(this._repository,this._chartsRepository, this._sessionController,this._followMapRepository);

  ProfileModel? getProfileModel() {
    final currentProfile = _sessionController.currentProfile;
    if(currentProfile == null) return null;
    return _repository.getOnce(currentProfile.id);
  }

  bool updateProfileModel(ProfileModel model) {
    final currentProfile = _sessionController.currentProfile;
    if(currentProfile == null) return false;
    return _repository.edit(currentProfile.id, model);
  }

  List<ChartModel> getCharts() {
    var profileModel = getProfileModel();
    if (profileModel == null) return [];
    return _chartsRepository.getChartsByOwner(profileModel);
  }
  void followUser(ProfileModel currentUser, ProfileModel followedUser) {
    var currentUserId = currentUser.id;
    var followedId = followedUser.id;
    final id = "$currentUserId:$followedId";
    final model = FollowModel(currentUserId, followedId);
    _followMapRepository.insert(id, model);
  }
}
