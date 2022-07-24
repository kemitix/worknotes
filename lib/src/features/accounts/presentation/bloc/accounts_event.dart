import 'package:equatable/equatable.dart';

import '../../domain/entities/account.dart';

abstract class AccountsEvent extends Equatable {}

class AddOrUpdateAccountEvent extends AccountsEvent {
  final Account account;

  AddOrUpdateAccountEvent(this.account);

  @override
  List<Object?> get props => [account];
}

class RemoveAccountEvent extends AccountsEvent {
  final Account account;

  RemoveAccountEvent(this.account);

  @override
  List<Object?> get props => [account];
}
