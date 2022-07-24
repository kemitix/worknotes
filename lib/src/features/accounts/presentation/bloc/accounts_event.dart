import 'package:equatable/equatable.dart';

import '../../domain/entities/account.dart';

abstract class AccountsEvent extends Equatable {}

class AccountAddedOrUpdated extends AccountsEvent {
  final Account account;

  AccountAddedOrUpdated(this.account);

  @override
  List<Object?> get props => [account];
}

class AccountRemoved extends AccountsEvent {
  final Account account;

  AccountRemoved(this.account);

  @override
  List<Object?> get props => [account];
}
