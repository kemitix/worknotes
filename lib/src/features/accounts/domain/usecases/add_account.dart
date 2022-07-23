import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

class AddAccount {
  final AccountRepository repository;

  AddAccount(this.repository);

  Future<Either<Failure, void>> execute({required Account account}) async {
    return repository.add(account);
  }
}
