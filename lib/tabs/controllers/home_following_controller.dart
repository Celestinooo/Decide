import 'package:decide/authentication/controller/session_controller.dart';
import 'package:decide/tabs/models/chart_comment.dart';
import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/chart_option.dart';
import 'package:decide/tabs/models/chart_vote.dart';
import 'package:decide/tabs/models/follow_model.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:decide/tabs/repository/map/chart_map_repository.dart';
import 'package:decide/tabs/repository/map/follow_map_repository.dart';

class HomeFollowingController {
  final ChartMapRepository _chartsRepository;
  final SessionController _sessionController;
  final FollowMapRepository _followMapRepository;

  HomeFollowingController(
    this._chartsRepository,
    this._sessionController,
    this._followMapRepository,
  );

  List<ChartModel> getCurrentUserFollowingCharts() {
    var currentProfile = _sessionController.currentProfile;
    if (currentProfile == null) return [];
    final currentUserId = currentProfile.id;
    final currentUserFollows = _followMapRepository
        .getAll()
        .where((element) => element.followerId == currentUserId)
        .toList();
    final chartList = <ChartModel>[];
    for (final userFollow in currentUserFollows) {
      chartList.addAll(_chartsRepository
          .getAll()
          .where((element) => element.owner.id == userFollow.followedId)
          .toList());
    }
    return chartList;
  }

  void vote(ChartModel chart, ChartOption option) {
    var isFirstOption = chart.option1.id == option.id ? true : false;
    var currentProfile = _sessionController.currentProfile;
    if (currentProfile == null) return;
    final voted = chart.chartVotes
        .where((element) => element.participant.id == currentProfile.id)
        .toList()
        .isNotEmpty;
    if (voted) return;
    chart.chartVotes
        .add(ChartVote(participant: currentProfile, option: option));

    chart.votes++;
    option.votes++;
    option.percentage = option.votes * 100 / chart.votes;
    if (isFirstOption) {
      chart.option1 = option;
    } else {
      chart.option2 = option;
    }
    _chartsRepository.edit(chart.id, chart);
  }

  void saveComment(ChartModel chart, String comment) {
    var currentProfile = _sessionController.currentProfile;
    if (currentProfile == null) return;
    final votes = chart.chartVotes
        .where((element) => element.participant.id == currentProfile.id)
        .toList();
    if (votes.isEmpty) return;
    final votedOption = votes.first.option;
    chart.chartComments.add(ChartComment(
        commentOwner: currentProfile,
        votedOption: votedOption,
        comment: comment));
    _chartsRepository.edit(chart.id, chart);
  }

  void followUser(ProfileModel currentUser, ProfileModel followedUser) {
    var currentUserId = currentUser.id;
    var followedId = followedUser.id;
    final id = "$currentUserId:$followedId";
    final model = FollowModel(currentUserId, followedId);
    _followMapRepository.insert(id, model);
  }
}
