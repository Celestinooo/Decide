import 'package:decide/authentication/controller/register_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  final RegisterController _registerController;

  _RegisterStore(this._registerController);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? register() => _registerController.register(
        loginController.text,
        passwordController.text,
        confirmPasswordController.text,
        nameController.text,
      );
}
