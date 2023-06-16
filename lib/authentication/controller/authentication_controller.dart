import 'package:decide/authentication/controller/session_controller.dart';
import 'package:decide/tabs/repository/map/profile_map_repository.dart';

class AuthenticationController {
  final ProfileMapRepository _repository;
  final SessionController _sessionController;

  AuthenticationController(this._repository, this._sessionController);

  bool authenticate(String login, String password){
    final profile = _repository.getByLogin(login);
    if(profile == null) return false;
    if(profile.password != password) return false;
    _sessionController.currentProfile = profile;
    return true;
  }
}