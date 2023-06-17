import 'package:decide/tabs/controllers/create_chart_controller.dart';
import 'package:decide/tabs/controllers/home_following_controller.dart';
import 'package:decide/tabs/controllers/profile_controller.dart';
import 'package:decide/tabs/controllers/users_controller.dart';
import 'package:decide/tabs/stores/create_chart_store.dart';
import 'package:decide/tabs/stores/following_store.dart';
import 'package:decide/tabs/stores/profile_store.dart';
import 'package:decide/tabs/stores/search_store.dart';
import 'package:decide/tabs/views/tabs_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TabsModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => ProfileStore(i())),
    Bind.lazySingleton((i) => CreateChartStore(i())),
    Bind.lazySingleton((i) => ProfileController(i(),i(),i(),i())),
    Bind.lazySingleton((i) => CreateChartController(i(),i())),
    Bind.lazySingleton((i) => FollowingStore(i(),i())),
    Bind.lazySingleton((i) => HomeFollowingController(i(),i(),i())),
    Bind.lazySingleton((i) => SearchStore(i())),
    Bind.lazySingleton((i) => UsersController(i(),i(),i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/", child: (context, args) => const TabsScreen()),
  ];
}
