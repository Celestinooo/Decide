abstract class Repository<T, Id> {
  bool insert(Id id, T model);

  bool edit(Id id, T model);

  T? getOnce(Id id);

  List<T> getAll();

  bool remove(Id id);
}
