import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknotes/src/features/accounts/accounts.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  void givenSavedAccounts(List<Account> accounts) {
    SharedPreferences.setMockInitialValues({
      'accounts': accounts
          .map((account) => AccountModel.fromAccount(account).toJson())
          .toList()
    });
    sharedPreferences.reload();
  }

  AccountsBloc accountsBloc() {
    final ds = SharedPreferencesAccountsLocalDataSource(sharedPreferences);
    final repository = LocalAccountRepository(ds);
    repository.load();
    var bloc = AccountsBloc(
      accountRepository: repository,
      addAccount: AddAccount(repository),
      removeAccount: RemoveAccount(repository),
      getAllAccounts: GetAllAccounts(repository),
    );
    bloc.add(LoadAccounts());
    return bloc;
  }

  test('Initial state is empty', () {
    expect(accountsBloc().state.accounts.isEmpty, isTrue);
  });

  final objectIdAlpha = ObjectId();
  final objectIdBeta = ObjectId();
  Account accountAlphaV1 = Account(
      id: objectIdAlpha,
      type: 'alpha',
      name: 'alpha-v1',
      key: 'key',
      secret: 'secret');
  Account accountAlphaV2 = Account(
      id: objectIdAlpha,
      type: 'alpha-alpha',
      name: 'v2',
      key: 'key',
      secret: 'secret');
  Account accountBetaV1 = Account(
      id: objectIdBeta,
      type: 'beta',
      name: 'beta-v1',
      key: 'key',
      secret: 'secret');

  blocTest<AccountsBloc, AccountsState>(
    'Add accounts',
    build: accountsBloc,
    setUp: () => givenSavedAccounts([accountBetaV1]),
    seed: () => AccountsState([accountBetaV1]),
    act: (bloc) => bloc.add(AccountAdded(accountAlphaV1)),
    expect: () => [
      AccountsState([accountBetaV1, accountAlphaV1]),
    ],
  );
  blocTest<AccountsBloc, AccountsState>(
    'Add an account where id already exists is an update',
    build: accountsBloc,
    setUp: () => givenSavedAccounts([accountAlphaV1]),
    act: (bloc) => bloc.add(AccountAdded(accountAlphaV2)),
    expect: () => [
      AccountsState([accountAlphaV2])
    ],
  );
  blocTest<AccountsBloc, AccountsState>(
    'Remove an account',
    build: accountsBloc,
    setUp: () => givenSavedAccounts([accountAlphaV1, accountBetaV1]),
    act: (bloc) => bloc.add(AccountRemoved(accountAlphaV1)),
    expect: () => [
      AccountsState([accountBetaV1])
    ],
  );
  blocTest<AccountsBloc, AccountsState>(
    'Removing an account that doesn\'t exist is ignored',
    build: accountsBloc,
    setUp: () => givenSavedAccounts([accountAlphaV1]),
    act: (bloc) => bloc.add(AccountRemoved(accountBetaV1)),
    expect: () => [
      AccountsState([accountAlphaV1])
    ],
  );
}
