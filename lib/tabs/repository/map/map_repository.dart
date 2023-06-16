import 'package:decide/tabs/repository/repository.dart';

class MapRepository<T, Id> extends Repository<T, Id> {
  final Map<Id, T> repo = {};

  @override
  bool edit(Id id, T model) {
    if (!repo.keys.contains(id)) return false;
    repo[id] = model;
    return true;
  }

  @override
  List<T> getAll() {
    return repo.values.toList();
  }

  @override
  T? getOnce(Id id) {
    if (!repo.keys.contains(id)) return null;
    return repo[id];
  }

  @override
  bool insert(Id id, T model) {
    if (repo.keys.contains(id)) return false;
    repo[id] = model;
    return true;
  }

  @override
  bool remove(Id id) {
    if (!repo.keys.contains(id)) return false;
    repo.removeWhere((key, value) => key == id);
    return true;
  }
}
