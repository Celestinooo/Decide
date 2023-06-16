import 'package:decide/tabs/models/profile_model.dart';

abstract class OnSendComment{
  void onSendComment(String text);
  void onFollowUser(ProfileModel currentUser, ProfileModel followedUser);
}