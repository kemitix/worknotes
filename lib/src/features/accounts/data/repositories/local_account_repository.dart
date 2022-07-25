import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:objectid/objectid.dart';
import 'package:worknotes/src/features/accounts/data/models/account_model.dart';

import '../../../../core/error/duplicate_record_error.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/not_found_error.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/accounts_local_datasource.dart';

//TODO hook this up to the AccountsBloc
class LocalAccountRepository extends AccountRepository {
  final AccountsLocalDataSource dataSource;

  LocalAccountRepository(this.dataSource);

  final List<Account> items = [];

  void load() => items.addAll(dataSource.loadAccounts().map((m) => Account(
      id: m.id, type: m.type, name: m.name, key: m.key, secret: m.secret)));

  void save() => dataSource.saveAccounts(items
      .map((e) => AccountModel(
            id: e.id,
            type: e.type,
            name: e.name,
            key: e.key,
            secret: e.secret,
          ))
      .toList(growable: false));

  // modifying methods:
  // should all call notifyListeners()

  Future<Either<Failure, Account>> add(Account item) async {
    if (items.contains(item)) {
      return Future.value(left(DuplicateError()));
    }
    items.add(item);
    save();
    notifyListeners();
    return Future.value(right(item));
  }

  Future<Either<Failure, Account>> remove(Account item) async {
    items.remove(item);
    save();
    notifyListeners();
    return Future.value(right(item));
  }

  Future<void> update(int index, Account item) async {
    items.setRange(index, index + 1, [item]);
    save();
    notifyListeners();
    return Future.value(null);
  }

  // read-only methods

  Future<Either<Failure, List<Account>>> getAll() {
    return Future.value(right(UnmodifiableListView(items)));
  }

  Future<Account> findById(ObjectId objectId) {
    try {
      return Future.value(items.firstWhere((item) => item.id == objectId));
    } on StateError {
      return Future.error(NotFoundError());
    }
  }

  Future<Account> findByName(String name) {
    try {
      return Future.value(items.firstWhere((item) => item.name == name));
    } on StateError {
      return Future.error(NotFoundError());
    }
  }
}