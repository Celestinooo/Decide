import 'package:decide/authentication/controller/authentication_controller.dart';
import 'package:mobx/mobx.dart';

part 'authentication_store.g.dart';

class AuthenticationStore = _AuthenticationStore with _$AuthenticationStore;

abstract class _AuthenticationStore with Store {
  String writtenLogin = "";
  String writtenPassword = "";
  final AuthenticationController controller;

  _AuthenticationStore(this.controller);

  bool login() => controller.authenticate(writtenLogin, writtenPassword);

}
