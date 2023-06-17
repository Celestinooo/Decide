import 'package:decide/tabs/controllers/create_chart_controller.dart';
import 'package:decide/tabs/controllers/users_controller.dart';
import 'package:decide/tabs/models/search_user_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  @observable
  var firstOptionMedia = "";
  @observable
  var secondOptionMedia = "";
  @observable
  var allowComments = true;
  @observable
  ObservableList<SearchUserModel> users = ObservableList();

  final TextEditingController inputController = TextEditingController();

  final UsersController _usersController;

  _SearchStore(this._usersController);

  @action
  void searchUsers() {
    users.clear();
    users.addAll(_usersController.findFiltered(inputController.text));
  }

  bool? isFollowing(SearchUserModel foundUser) {
    return _usersController.isFollowing(foundUser);
  }

  void follow(SearchUserModel foundUser) {
    _usersController.follow(foundUser);
    searchUsers();
  }

  void unfollow(SearchUserModel foundUser) {
    _usersController.unfollow(foundUser);
    searchUsers();
  }
}
