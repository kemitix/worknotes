import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectid/objectid.dart';
import 'package:worknotes/src/features/accounts/domain/entities/account.dart';
import 'package:worknotes/src/features/accounts/domain/usecases/add_account.dart';
import 'package:worknotes/src/features/accounts/domain/usecases/get_all_accounts.dart';
import 'package:worknotes/src/features/accounts/domain/usecases/remove_account.dart';
import 'package:worknotes/src/features/accounts/presentation/bloc/accounts_bloc.dart';
import 'package:worknotes/src/features/accounts/presentation/bloc/accounts_event.dart';
import 'package:worknotes/src/features/accounts/presentation/bloc/accounts_state.dart';

import 'accounts_bloc_test.mocks.dart';

@GenerateMocks([AddAccount, RemoveAccount, GetAllAccounts])
void main() {
  late AccountsBloc accountsBloc;
  setUp(() {
    final mockAddAccount = MockAddAccount();
    final mockRemoveAccount = MockRemoveAccount();
    final mockGetAllAccounts = MockGetAllAccounts();
    when(mockGetAllAccounts.call(any))
        .thenAnswer((_) => Future.value(right([])));
    when(mockAddAccount.call(any)).thenAnswer((realInvocation) =>
        Future.value(right(realInvocation.positionalArguments[0])));
    when(mockRemoveAccount.call(any)).thenAnswer((realInvocation) =>
        Future.value(right(realInvocation.positionalArguments[0])));
    accountsBloc = AccountsBloc.load(
      addAccount: mockAddAccount,
      removeAccount: mockRemoveAccount,
      getAllAccounts: mockGetAllAccounts,
    );
  });
  test('Initial state is empty', () {
    expect(accountsBloc.state.accounts.isEmpty, isTrue);
  });
  final objectIdAlpha = ObjectId();
  final objectIdBeta = ObjectId();
  Account accountAlphaV1 = Account(
      id: objectIdAlpha,
      type: 'type 1',
      name: 'name 1',
      key: 'key 1',
      secret: 'secret 1');
  Account accountAlphaV2 = Account(
      id: objectIdAlpha,
      type: 'type 2',
      name: 'name 2',
      key: 'key 2',
      secret: 'secret 2');
  Account accountBetaV1 = Account(
      id: objectIdBeta,
      type: 'type 1',
      name: 'name 1',
      key: 'key 1',
      secret: 'secret 1');
  blocTest<AccountsBloc, AccountsState>(
    'Add accounts',
    build: () => accountsBloc,
    seed: () => const AccountsState([]),
    act: (bloc) {
      bloc.add(AccountAddedOrUpdated(accountAlphaV1));
      bloc.add(AccountAddedOrUpdated(accountBetaV1));
    },
    expect: () => [
      AccountsState([accountAlphaV1]),
      AccountsState([accountAlphaV1, accountBetaV1])
    ],
  );
  blocTest<AccountsBloc, AccountsState>(
    'Add an account where id already exists is an update',
    build: () => accountsBloc,
    seed: () => AccountsState([accountAlphaV1]),
    act: (bloc) => bloc.add(AccountAddedOrUpdated(accountAlphaV2)),
    expect: () => [
      AccountsState([accountAlphaV2])
    ],
  );
  blocTest<AccountsBloc, AccountsState>(
    'Remove an account',
    build: () => accountsBloc,
    seed: () => AccountsState([accountAlphaV1]),
    act: (bloc) => bloc.add(AccountRemoved(accountAlphaV1)),
    expect: () => const [AccountsState([])],
  );
  blocTest<AccountsBloc, AccountsState>(
    'Removing an account that doesn\'t exist is ignored',
    build: () => accountsBloc,
    seed: () => AccountsState([accountAlphaV1]),
    act: (bloc) => bloc.add(AccountRemoved(accountBetaV1)),
    expect: () => [], // no changes
  );
}
