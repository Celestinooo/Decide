import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/profile_model.dart';

abstract class OnCommentSent{
  void onCommentSent(ChartModel chartModel, String comment);
  void onFollowUser(ProfileModel currentUser, ProfileModel followedUser);
}