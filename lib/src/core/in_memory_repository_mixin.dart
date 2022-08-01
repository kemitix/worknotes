import 'dart:collection';

import 'package:dartz/dartz.dart';

import 'error/duplicate_record_error.dart';
import 'error/failure.dart';

abstract class InMemoryRepository<T> {
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
    return Future.value(right(item));
  }

  // read-only methods

  Future<Either<Failure, List<T>>> getAll() {
    return Future.value(right(UnmodifiableListView(items)));
  }
}
