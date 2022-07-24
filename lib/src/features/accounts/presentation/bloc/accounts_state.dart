import 'package:equatable/equatable.dart';

import '../../domain/entities/account.dart';

class AccountsState extends Equatable {
  final List<Account> accounts;

  const AccountsState(this.accounts);

  @override
  List<Object?> get props => [accounts];
}
