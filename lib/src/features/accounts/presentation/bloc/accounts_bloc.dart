import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/not_found_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/add_account.dart';
import '../../domain/usecases/get_all_accounts.dart';
import '../../domain/usecases/remove_account.dart';
import 'accounts_event.dart';
import 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AddAccount addAccount;
  final RemoveAccount removeAccount;
  final GetAllAccounts getAllAccounts;

  AccountsBloc._({
    required this.addAccount,
    required this.removeAccount,
    required this.getAllAccounts,
  }) : super(const AccountsState([])) {
    on<LoadAccounts>((event, emit) async {
      (await getAllAccounts.call(NoParams()))
          .map((accounts) => emit(AccountsState(accounts)));
    });
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

  static AccountsBloc load({
    required AddAccount addAccount,
    required RemoveAccount removeAccount,
    required GetAllAccounts getAllAccounts,
  }) {
    final bloc = AccountsBloc._(
        addAccount: addAccount,
        removeAccount: removeAccount,
        getAllAccounts: getAllAccounts);
    bloc.add(LoadAccounts());
    return bloc;
  }
}
