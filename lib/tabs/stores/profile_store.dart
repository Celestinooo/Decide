import 'package:decide/tabs/controllers/profile_controller.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:mobx/mobx.dart';

import '../models/chart_model.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  @observable
  String name = "";
  @observable
  String description = "";
  @observable
  String imagePath = "";

  String editingName = "";
  String editingDescription = "";
  @observable
  String editingImagePath = "";

  ObservableList<ChartModel> charts = ObservableList();

  final ProfileController _controller;

  _ProfileStore(this._controller);

  void openProfileEdit() {
    editingName = name;
    editingDescription = description;
    editingImagePath = imagePath;
  }

  @action
  void getProfile() {
    final profile = _controller.getProfileModel();
    if (profile == null) return;
    name = profile.name;
    description = profile.description;
    imagePath = profile.imagePath;
  }

  ProfileModel? getRepoProfile() {
    return _controller.getProfileModel();
  }

  @action
  void getCharts() {
    final chartsFound = _controller.getCharts();
    charts.clear();
    charts.addAll(chartsFound);
  }

  void saveProfile() {
    final profile = ProfileModel(
      name: editingName,
      description: editingDescription,
      imagePath: editingImagePath,
    );
    _controller.updateProfileModel(profile);
    getProfile();
    getCharts();
  }

  ProfileModel? getCurrentUser() {
    return _controller.getProfileModel();
  }

  void followUser(ProfileModel currentUser, ProfileModel followedUser){
    _controller.followUser(currentUser,followedUser);
  }
}
