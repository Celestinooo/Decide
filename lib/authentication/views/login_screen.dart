import 'package:decide/authentication/store/authentication_store.dart';
import 'package:decide/authentication/views/authentication_failed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ModularState<LoginScreen, AuthenticationStore> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              " Entrar",
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
            Container(
              margin: const EdgeInsets.only(left: 60, right: 60, top: 20),
              child: TextField(
                controller: loginController,
                onChanged: (value) {
                  store.writtenLogin = value;
                },
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 60, right: 60, top: 20),
              child: TextField(
                controller: passwordController,
                onChanged: (value) {
                  store.writtenPassword = value;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 60, right: 60, top: 20),
                    child: ElevatedButton(
                      onPressed: _onEnterPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 60, right: 60, top: 20),
                    child: OutlinedButton(
                      onPressed: _onRegisterPressed,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onEnterPressed() {
    final loginSuccess = store.login();
    if (loginSuccess) {
      Modular.to.pushNamed("/tabs");
      store.writtenLogin = "";
      store.writtenPassword = "";
      loginController.clear();
      passwordController.clear();
    } else {
      showDialog(
        context: context,
        builder: (context) => const AuthenticationFailedDialog(
            title: "Falha na autenticação",
            content:
                'Por favor, verifique suas credenciais e tente novamente.'),
      );
    }
  }

  void _onRegisterPressed(){
    Modular.to.pushNamed("/register");
  }
}
