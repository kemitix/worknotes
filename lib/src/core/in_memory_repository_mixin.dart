import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:objectid/objectid.dart';

import 'error/duplicate_record_error.dart';
import 'error/failure.dart';
import 'error/not_found_error.dart';
import 'has_id_name.dart';

abstract class InMemoryRepository<T extends HasIdName> {
  final List<T> items = [];

  void notifyListeners();

  // modifying methods:
  // should all call notifyListeners()

  Future<Either<Failure, T>> add(T item) {
    if (items.contains(item)) {
      return Future.value(left(DuplicateError()));
    }
    items.add(item);
    notifyListeners();
    return Future.value(right(item));
  }

  Future<Either<Failure, T>> remove(T item) {
    items.remove(item);
    notifyListeners();
    return Future.value(right(item));
  }

  Future<Either<Failure, T>> update(int index, T item) {
    items.setRange(index, index + 1, [item]);
    notifyListeners();
    return Future.value(null);
  }

  // read-only methods

  Future<Either<Failure, List<T>>> getAll() {
    return Future.value(right(UnmodifiableListView(items)));
  }

  Future<Either<Failure, T>> findById(ObjectId objectId) {
    try {
      return Future.value(
          right(items.firstWhere((item) => item.id == objectId)));
    } on StateError {
      return Future.value(left(NotFoundError()));
    }
  }

  Future<Either<Failure, T>> findByName(String name) {
    try {
      return Future.value(right(items.firstWhere((item) => item.name == name)));
    } on StateError {
      return Future.value(left(NotFoundError()));
    }
  }
}
