import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../accounts.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AddAccount addAccount;
  final RemoveAccount removeAccount;
  final GetAllAccounts getAllAccounts;
  final AccountRepository accountRepository;

  AccountsBloc._({
    required this.addAccount,
    required this.removeAccount,
    required this.getAllAccounts,
    required this.accountRepository,
  }) : super(const AccountsState([])) {
    on<LoadAccounts>(_onLoadAccounts);
    on<AccountAdded>(_onAddAccount);
    on<AccountRemoved>(_onRemoveAccount);
  }

  FutureOr<void> _onLoadAccounts(event, emit) async {
    (await getAllAccounts.call(NoParams())).fold(
      (failure) => addError(failure),
      (accounts) => emit(AccountsState(accounts)),
    );
  }

  FutureOr<void> _onAddAccount(event, emit) async {
    (await addAccount.call(event.account)).fold(
      (failure) => addError(failure),
      (account) => add(LoadAccounts()),
    );
  }

  FutureOr<void> _onRemoveAccount(event, emit) async {
    (await removeAccount.call(event.account)).fold(
      (failure) => addError(failure),
      (account) => add(LoadAccounts()),
    );
  }

  static AccountsBloc load({
    required AddAccount addAccount,
    required RemoveAccount removeAccount,
    required GetAllAccounts getAllAccounts,
    required AccountRepository accountRepository,
  }) {
    final bloc = AccountsBloc._(
      addAccount: addAccount,
      removeAccount: removeAccount,
      getAllAccounts: getAllAccounts,
      accountRepository: accountRepository,
    );
    bloc.add(LoadAccounts());
    return bloc;
  }
}
