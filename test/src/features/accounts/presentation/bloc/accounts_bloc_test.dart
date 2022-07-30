import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknotes/src/features/accounts/accounts.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  AccountsBloc accountsBloc() {
    final ds = SharedPreferencesAccountsLocalDataSource(sharedPreferences);
    final repository = LocalAccountRepository(ds);
    return AccountsBloc.load(
      accountRepository: repository,
      addAccount: AddAccount(repository),
      removeAccount: RemoveAccount(repository),
      getAllAccounts: GetAllAccounts(repository),
    );
  }

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('Initial state is empty', () {
    expect(accountsBloc().state.accounts.isEmpty, isTrue);
  });

  final objectIdAlpha = ObjectId();
  final objectIdBeta = ObjectId();
  Account accountAlphaV1 = Account(
      id: objectIdAlpha,
      type: 'alpha',
      name: 'v1',
      key: 'key',
      secret: 'secret');
  Account accountAlphaV2 = Account(
      id: objectIdAlpha,
      type: 'alpha',
      name: 'v2',
      key: 'key',
      secret: 'secret');
  Account accountBetaV1 = Account(
      id: objectIdBeta, type: 'beta', name: 'v1', key: 'key', secret: 'secret');

  blocTest<AccountsBloc, AccountsState>(
    'Add accounts',
    build: accountsBloc,
    seed: () => const AccountsState([]),
    act: (bloc) {
      bloc.add(AccountAdded(accountAlphaV1));
    },
    expect: () => [
      AccountsState([accountAlphaV1]),
    ],
  );
  blocTest<AccountsBloc, AccountsState>(
    'Add an account where id already exists is an update',
    build: accountsBloc,
    seed: () => const AccountsState([]),
    act: (bloc) {
      bloc.add(AccountAdded(accountAlphaV1));
      bloc.add(AccountAdded(accountAlphaV2));
    },
    expect: () => [
      AccountsState([accountAlphaV2]) // replaces v1
    ],
  );
  blocTest<AccountsBloc, AccountsState>(
    'Remove an account',
    build: accountsBloc,
    seed: () => const AccountsState([]),
    act: (bloc) {
      bloc.add(AccountAdded(accountAlphaV1));
      bloc.add(AccountRemoved(accountAlphaV1));
    },
    expect: () => [const AccountsState([])],
  );
  blocTest<AccountsBloc, AccountsState>(
    'Removing an account that doesn\'t exist is ignored',
    build: accountsBloc,
    seed: () => AccountsState([accountAlphaV1]),
    act: (bloc) {
      bloc.add(AccountAdded(accountAlphaV1));
      bloc.add(AccountRemoved(accountBetaV1));
    },
    expect: () => [
      AccountsState([accountAlphaV1])
    ],
  );
}
