import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/account_model.dart';

abstract class AccountsLocalDataSource {
  List<AccountModel> loadAccounts();

  void saveAccounts(List<AccountModel> accountModels);
}

class SharedPreferencesAccountsLocalDataSource
    implements AccountsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SharedPreferencesAccountsLocalDataSource(this.sharedPreferences);

  @override
  List<AccountModel> loadAccounts() =>
      (sharedPreferences.getStringList('accounts') ?? [])
          .map((json) => jsonDecode(json))
          .map((map) => AccountModel.fromMap(map))
          .toList();

  @override
  void saveAccounts(List<AccountModel> accountModels) {
    sharedPreferences.setStringList(
        'accounts',
        accountModels
            .map((AccountModel e) => e.toMap())
            .map((map) => json.encode(map))
            .toList());
  }
}
