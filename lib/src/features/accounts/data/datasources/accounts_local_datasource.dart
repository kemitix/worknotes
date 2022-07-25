import '../models/account_model.dart';

abstract class AccountsLocalDataSource {
  Future<List<AccountModel>> loadAccounts();

  Future<void> saveAccounts(List<AccountModel> accountModels);
}
