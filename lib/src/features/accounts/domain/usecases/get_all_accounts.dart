import 'package:dartz/dartz.dart';
import 'package:worknotes/src/core/error/failure.dart';
import 'package:worknotes/src/core/usecases/usecase.dart';
import 'package:worknotes/src/features/accounts/domain/entities/account.dart';
import 'package:worknotes/src/features/accounts/domain/repositories/account_repository.dart';

class GetAllAccounts implements UseCase<List<Account>, NoParams> {
  final AccountRepository repository;

  GetAllAccounts(this.repository);

  Future<Either<Failure, List<Account>>> call(NoParams noParams) =>
      repository.getAll();
}
