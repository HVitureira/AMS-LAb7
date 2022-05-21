class Entry<T> {
  Entry({required this.builder});

  final T Function() builder;
  T? _instance;

  T? get instance {
    return _instance ??= builder();
  }
}

class Archiver<T> {
  final _archiver = <Type, Entry<T>>{};

  void archive<S extends T>(Entry<S> entry) => _archiver.addAll({S: entry});

  T? retrieve<S extends T>() => _archiver[S]?.instance;

  void clear() => _archiver.clear();

  List<T?> get items => _archiver.values.map((e) => e.instance).toList();
}
