import 'package:decide/authentication/controller/session_controller.dart';
import 'package:decide/tabs/controllers/home_following_controller.dart';
import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/chart_option.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:mobx/mobx.dart';

part 'following_store.g.dart';

class FollowingStore = _FollowingStore with _$FollowingStore;

abstract class _FollowingStore with Store {
  @observable
  ObservableList charts = ObservableList<ChartModel>();

  final HomeFollowingController _controller;

  final SessionController _sessionController;

  _FollowingStore(this._controller,this._sessionController);

  @action
  void getCharts() {
    charts.clear();
    charts.addAll(_controller.getCurrentUserFollowingCharts());
  }

  void vote(ChartModel chart, ChartOption option){
    _controller.vote(chart,option);
  }

  void saveComment(ChartModel chart, String comment) {
    _controller.saveComment(chart,comment);
  }

  void followUser(ProfileModel currentUser, ProfileModel followedUser){
    _controller.followUser(currentUser,followedUser);
  }

  ProfileModel? getProfileModel(){
    return _sessionController.currentProfile;
  }



}