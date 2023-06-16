import 'package:decide/authentication/controller/session_controller.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:decide/tabs/repository/map/profile_map_repository.dart';

class RegisterController {
  final ProfileMapRepository _repository;
  final SessionController _sessionController;

  RegisterController(this._repository, this._sessionController);

  String? register(String login,String password, String confirmPassword, String name){
    if(login.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty) return "Preencha todos os campos";
    if(password != confirmPassword) return "As senhas não coincidem";
    final profile = _repository.getByLogin(login);
    if(profile != null) return "Usuário já cadastrado";
    var nextId = _repository.getNextId();
    final model = ProfileModel(id: nextId, login: login, password: password, name: name, description: "", imagePath: "");
    _repository.insert(nextId, model);
    _sessionController.currentProfile = model;
    return null;
  }
}