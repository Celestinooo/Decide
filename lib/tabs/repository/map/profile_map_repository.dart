import 'package:decide/tabs/models/profile_model.dart';
import 'package:decide/tabs/repository/map/map_repository.dart';

class ProfileMapRepository extends MapRepository<ProfileModel, int> {
  ProfileMapRepository() {
    insert(
      0,
      ProfileModel(
        id: 0,
        login: "lucao",
        password: "123",
        name: "Lucas",
        description: "21 | Mobile",
        imagePath: "",
      ),
    );insert(
      1,
      ProfileModel(
        id: 1,
        login: "pedro",
        password: "123",
        name: "Pedro",
        description: "25 | Desktop",
        imagePath: "",
      ),
    );
  }
  @override
  bool edit(int id, ProfileModel model) {
    final m = getOnce(id);
    if(m == null) return false;
    model.id = m.id;
    model.login = m.login;
    model.password = m.password;
    return super.edit(id, model);
  }

  ProfileModel? getByLogin(String login ){
    final profiles = getAll();
    for (var profile in profiles) {
      if(profile.login != login) continue;
      return profile;
    }
    return null;
  }

  int getNextId(){
    var all = getAll();
    return all.isEmpty ? 0 : all.last.id+1;
  }
}
