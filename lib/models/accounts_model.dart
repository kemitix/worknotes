import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:objectbox/src/native/store.dart';

import 'account.dart';

class AccountsModel extends ChangeNotifier {
  final Store _store;

  AccountsModel(this._store);

  UnmodifiableListView<Account> get accounts =>
      UnmodifiableListView(_store.box<Account>().getAll());

  void add(Account account) {
    _store.box<Account>().put(account);
    notifyListeners();
  }

  void remove(Account account) {
    _store.box<Account>().remove(account.id);
    notifyListeners();
  }
}
