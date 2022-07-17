import 'dart:collection';

import 'package:flutter/material.dart';

import '../../objectbox.g.dart';
import 'has_id.dart';

class Storage<T extends HasId> extends ChangeNotifier {
  final Store _store;

  Storage(this._store);

  UnmodifiableListView<T> get items =>
      UnmodifiableListView(_store.box<T>().getAll());

  void add(T item) {
    _store.box<T>().put(item);
    notifyListeners();
  }

  void remove(T item) {
    _store.box<T>().remove(item.id);
    notifyListeners();
  }
}
