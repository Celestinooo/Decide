import 'dart:ffi';

import 'package:decide/authentication/controller/session_controller.dart';
import 'package:decide/tabs/models/follow_model.dart';
import 'package:decide/tabs/models/search_user_model.dart';
import 'package:decide/tabs/repository/map/follow_map_repository.dart';
import 'package:decide/tabs/repository/map/profile_map_repository.dart';

class UsersController {
  final ProfileMapRepository _repository;
  final SessionController _sessionController;
  final FollowMapRepository _followMapRepository;

  UsersController(this._repository,this._sessionController,this._followMapRepository);

  List<SearchUserModel> findFiltered(String input) {
    return _repository.getAll().where((e) {
      final nameStartsWithInput = e.name.toLowerCase().startsWith(input.toLowerCase());
      final loginStartsWithInput = e.login.toLowerCase().startsWith(input.toLowerCase());
      if(input.isEmpty) return false;
      return nameStartsWithInput || loginStartsWithInput;
    }).map((e) => SearchUserModel(id: e.id, name: e.name, login: e.login, imageUrl: e.imagePath)).toList();
  }

  bool? isFollowing(SearchUserModel foundUser) {
    final currentUserID = _sessionController.currentProfile?.id;
    if(currentUserID == null) return false;
    if(currentUserID == foundUser.id) return null;
    return _followMapRepository.getAll().where((element) => element.followerId == currentUserID && element.followedId == foundUser.id).toList().isNotEmpty;
  }

  void follow(SearchUserModel foundUser) {
    if(isFollowing(foundUser) != false) return;
    var currentUserId = _sessionController.currentProfile?.id;
    if(currentUserId == null) return;
    var followedId = foundUser.id;
    final id = "$currentUserId:$followedId";
    final model = FollowModel(currentUserId, followedId);
    _followMapRepository.insert(id, model);
  }
  void unfollow(SearchUserModel foundUser) {
    if(isFollowing(foundUser) != true) return;
    var currentUserId = _sessionController.currentProfile?.id;
    if(currentUserId == null) return;
    var followedId = foundUser.id;
    final id = "$currentUserId:$followedId";
    _followMapRepository.remove(id);
  }
}
