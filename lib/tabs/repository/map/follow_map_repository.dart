import 'package:decide/tabs/models/follow_model.dart';
import 'package:decide/tabs/repository/map/map_repository.dart';

class FollowMapRepository extends MapRepository<FollowModel, String> {
  FollowMapRepository() {
    insert(
    "lucao:pedro", FollowModel(0, 1));
  }
}
