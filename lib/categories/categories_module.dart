import 'package:decide/authentication/authentication_module.dart';
import 'package:decide/categories/views/categories_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoriesModule extends Module {
  @override
  List<Bind> get binds => [
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/", child: (context, args) => const CategoriesScreen()),
  ];
}
