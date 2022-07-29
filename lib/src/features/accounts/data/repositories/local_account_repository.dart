import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:objectid/objectid.dart';

import '../../../../core/error/duplicate_record_error.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/not_found_error.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/accounts_local_datasource.dart';
import '../models/account_model.dart';

class LocalAccountRepository extends AccountRepository {
  final AccountsLocalDataSource dataSource;

  LocalAccountRepository(this.dataSource) {
    load();
  }

  final List<Account> _items = [];

  void load() =>
      _items.addAll(dataSource
          .loadAccounts()
          .map((m) =>
          Account(
              id: m.id,
              type: m.type,
              name: m.name,
              key: m.key,
              secret: m.secret))
          .toList());

  void save() =>
      dataSource.saveAccounts(_items
          .map((e) =>
          AccountModel(
            id: e.id,
            type: e.type,
            name: e.name,
            key: e.key,
            secret: e.secret,
          ))
          .toList(growable: false));

  // modifying methods:
  // should all call notifyListeners()

  @override
  Future<Either<Failure, Account>> add(Account item) async {
    if (_items.contains(item) || _containsItemWithSameName(item)) {
      return Future.value(left(DuplicateError()));
    }
    _items.add(item);
    save();
    notifyListeners();
    return Future.value(right(item));
  }

  @override
  Future<Either<Failure, Account>> remove(Account item) async {
    if (!_items.contains(item)) {
      return Future.value(left(NotFoundError()));
    }
    _items.remove(item);
    save();
    notifyListeners();
    return Future.value(right(item));
  }

  bool _containsItemWithSameName(Account account) {
    return _items
        .where((e) => e.name == account.name)
        .isNotEmpty;
  }

  @override
  Future<Either<Failure, Account>> update(int index, Account item) async {
    if (index < 0 || index >= _items.length) {
      return Future.value(left(NotFoundError()));
    }
    Account original = _items.removeAt(index);
    if (_items.contains(item) || _containsItemWithSameName(item)) {
      _items.insert(index, original);
      return Future.value(left(DuplicateError()));
    }
    _items.insert(index, item);
    save();
    notifyListeners();
    return Future.value(right(item));
  }

  // read-only methods

  @override
  Future<Either<Failure, List<Account>>> getAll() {
    return Future.value(right(UnmodifiableListView(_items)));
  }

  @override
  Future<Either<Failure, Account>> findById(ObjectId objectId) {
    try {
      return Future.value(
          right(_items.firstWhere((item) => item.id == objectId)));
    } on StateError {
      return Future.value(left(NotFoundError()));
    }
  }

  @override
  Future<Either<Failure, Account>> findByName(String name) {
    try {
      return Future.value(
          right(_items.firstWhere((item) => item.name == name)));
    } on StateError {
      return Future.value(left(NotFoundError()));
    }
  }
}
