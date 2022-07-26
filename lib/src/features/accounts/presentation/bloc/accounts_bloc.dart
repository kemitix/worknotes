import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknotes/src/core/error/not_found_error.dart';

import '../../domain/usecases/add_account.dart';
import '../../domain/usecases/remove_account.dart';
import 'accounts_event.dart';
import 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AddAccount addAccount;
  final RemoveAccount removeAccount;

  AccountsBloc({
    required this.addAccount,
    required this.removeAccount,
  }) : super(const AccountsState([])) {
    on<AccountAddedOrUpdated>((event, emit) async {
      if (state.accounts.any((account) => account.id == event.account.id)) {
        // update
        (await addAccount.call(event.account)).map((account) => emit(
                AccountsState([
              ...state.accounts.map((a) => a.id == account.id ? account : a)
            ])));
      } else {
        // insert
        (await addAccount.call(event.account)).map(
            (account) => emit(AccountsState([...state.accounts, account])));
      }
    });
    on<AccountRemoved>((event, emit) async {
      if (state.accounts.any((account) => account.id == event.account.id)) {
        (await removeAccount.call(event.account))
            .map((account) => emit(AccountsState([
                  ...state.accounts.where((a) => a.id != account.id),
                ])));
      } else {
        addError(NotFoundError(), StackTrace.current);
      }
    });
  }
}
