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
          .map((json) => AccountModel.fromJson(json))
          .toList();

  @override
  void saveAccounts(List<AccountModel> accountModels) {
    sharedPreferences.setStringList(
        'accounts', accountModels.map((model) => model.toJson()).toList());
  }
}
