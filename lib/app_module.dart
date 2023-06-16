import 'package:decide/authentication/authentication_module.dart';
import 'package:decide/authentication/controller/session_controller.dart';
import 'package:decide/categories/categories_module.dart';
import 'package:decide/tabs/repository/map/chart_map_repository.dart';
import 'package:decide/tabs/repository/map/follow_map_repository.dart';
import 'package:decide/tabs/repository/map/profile_map_repository.dart';
import 'package:decide/tabs/tabs_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => ProfileMapRepository()),
    Bind.lazySingleton((i) => ChartMapRepository()),
    Bind.lazySingleton((i) => SessionController()),
    Bind.lazySingleton((i) => FollowMapRepository()),
  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute("/", module: AuthenticationModule()),
    ModuleRoute("/categories", module: CategoriesModule()),
    ModuleRoute("/tabs", module: TabsModule())
  ];
}
