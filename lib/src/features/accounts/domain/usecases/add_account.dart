import 'package:dartz/dartz.dart';
import 'package:worknotes/src/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

class AddAccount implements UseCase<Account, Account> {
  final AccountRepository repository;

  AddAccount(this.repository);

  @override
  Future<Either<Failure, Account>> call(Account account) async =>
      repository.add(account);
}
