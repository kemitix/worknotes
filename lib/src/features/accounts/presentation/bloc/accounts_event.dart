import 'package:equatable/equatable.dart';

import '../../domain/entities/account.dart';

abstract class AccountsEvent extends Equatable {}

class LoadAccounts extends AccountsEvent {
  @override
  List<Object?> get props => [];
}

class AccountAdded extends AccountsEvent {
  final Account account;

  AccountAdded(this.account);

  @override
  List<Object?> get props => [account];
}

class AccountRemoved extends AccountsEvent {
  final Account account;

  AccountRemoved(this.account);

  @override
  List<Object?> get props => [account];
}
