import 'package:decide/app.dart';
import 'package:decide/app_module.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized().then(
    (value) => {
      runApp(
        ModularApp(
          module: AppModule(), child: const App(),
        ),
      )
    },
  );
}
