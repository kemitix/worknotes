import 'dart:collection';

import 'package:flutter/material.dart';

import 'account.dart';

class AccountsModel extends ChangeNotifier {
  final Map<AccountName, Account> _accounts = {};

  UnmodifiableListView<Account> get accounts =>
      UnmodifiableListView(_accounts.values);

  void add(Account account) {
    // invariants:
    // account name must be unique
    _accounts.update(account.name, (_) => account, ifAbsent: () => account);
    notifyListeners();
  }

  void remove(AccountName accountName) {
    _accounts.remove(accountName);
    notifyListeners();
  }
}
