import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

class RemoveAccount {
  final AccountRepository repository;

  RemoveAccount(this.repository);

  Future<Either<Failure, Account>> execute({required Account account}) async {
    return repository.remove(account);
  }
}
