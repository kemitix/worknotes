import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectid/objectid.dart';
import 'package:worknotes/src/features/accounts/domain/entities/account.dart';
import 'package:worknotes/src/features/accounts/presentation/bloc/accounts_bloc.dart';
import 'package:worknotes/src/features/accounts/presentation/bloc/accounts_event.dart';
import 'package:worknotes/src/features/accounts/presentation/bloc/accounts_state.dart';

void main() {
  test('Initial state is empty', () {
    //given
    final bloc = AccountsBloc();
    //then
    expect(bloc.state.accounts.isEmpty, isTrue);
  });
  late AccountsBloc accountsBloc;
  setUp(() {
    accountsBloc = AccountsBloc();
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
