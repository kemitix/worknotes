import 'package:dartz/dartz.dart';
import 'package:worknotes/src/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

class RemoveAccount implements UseCase<Account, Account> {
  final AccountRepository repository;

  RemoveAccount(this.repository);

  @override
  Future<Either<Failure, Account>> call(Account account) async =>
      repository.remove(account);
}
