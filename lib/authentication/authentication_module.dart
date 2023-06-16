import 'package:decide/authentication/controller/authentication_controller.dart';
import 'package:decide/authentication/controller/register_controller.dart';
import 'package:decide/authentication/store/authentication_store.dart';
import 'package:decide/authentication/store/register_store.dart';
import 'package:decide/authentication/views/login_screen.dart';
import 'package:decide/authentication/views/register_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthenticationModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => AuthenticationStore(i())),
    Bind.lazySingleton((i) => RegisterStore(i())),
    Bind.lazySingleton((i) => AuthenticationController(i(),i())),
    Bind.lazySingleton((i) => RegisterController(i(),i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/", child:(context, args) => const LoginScreen()),
    ChildRoute("/register", child:(context, args) => const RegisterScreen()),
  ];
}
