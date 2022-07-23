import 'dart:collection';

import 'package:objectid/objectid.dart';

import 'error/duplicate_record_error.dart';
import 'error/not_found_error.dart';
import 'has_id_name.dart';

abstract class InMemoryRepository<T extends HasIdName> {
  final List<T> items = [];

  void notifyListeners();

  // modifying methods:
  // should all call notifyListeners()

  Future<void> add(T item) {
    if (items.contains(item)) {
      return Future.error(DuplicateError());
    }
    items.add(item);
    notifyListeners();
    return Future.value(null);
  }

  Future<void> remove(T item) {
    items.remove(item);
    notifyListeners();
    return Future.value(null);
  }

  Future<void> update(int index, T item) {
    items.setRange(index, index + 1, [item]);
    notifyListeners();
    return Future.value(null);
  }

  // read-only methods

  Future<List<T>> getAll() {
    return Future.value(UnmodifiableListView(items));
  }

  Future<T> findById(ObjectId objectId) {
    try {
      return Future.value(items.firstWhere((item) => item.id == objectId));
    } on StateError {
      return Future.error(NotFoundError());
    }
  }

  @override
  Future<T> findByName(String name) {
    try {
      return Future.value(items.firstWhere((item) => item.name == name));
    } on StateError {
      return Future.error(NotFoundError());
    }
  }
}
