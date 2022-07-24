import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknotes/src/core/error/not_found_error.dart';

import 'accounts_event.dart';
import 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc() : super(const AccountsState([])) {
    on<AddOrUpdateAccountEvent>((event, emit) {
      if (state.accounts.any((account) => account.id == event.account.id)) {
        // update
        emit(AccountsState([
          ...state.accounts.map((account) =>
              account.id == event.account.id ? event.account : account)
        ]));
      } else {
        // insert
        emit(AccountsState([...state.accounts, event.account]));
      }
    });
    on<RemoveAccountEvent>((event, emit) {
      if (state.accounts.any((account) => account.id == event.account.id)) {
        emit(AccountsState([
          ...state.accounts.where((account) => account.id != event.account.id),
        ]));
      } else {
        addError(NotFoundError(), StackTrace.current);
      }
    });
  }
}
