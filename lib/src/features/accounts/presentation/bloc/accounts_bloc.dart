import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../accounts.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AddAccount addAccount;
  final RemoveAccount removeAccount;
  final GetAllAccounts getAllAccounts;
  final AccountRepository accountRepository;

  AccountsBloc({
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
    var either = await getAllAccounts.call(NoParams());
    either.fold(
      (failure) => addError(failure),
      (accounts) => emit(AccountsState(accounts)),
    );
  }

  FutureOr<void> _onAddAccount(event, emit) async {
    var either = await addAccount.call(event.account);
    if (either.isRight()) {
      await _onLoadAccounts(event, emit);
    } else {
      either.swap().map((failure) => addError(failure));
    }
  }

  FutureOr<void> _onRemoveAccount(event, emit) async {
    var either = await removeAccount.call(event.account);
    if (either.isRight()) {
      await _onLoadAccounts(event, emit);
    } else {
      either.swap().map((failure) => addError(failure));
    }
  }
}
