import 'package:dartz/dartz.dart';
import 'package:objectid/src/objectid/objectid.dart';
import 'package:worknotes/src/core/error/failure.dart';
import 'package:worknotes/src/features/accounts/data/datasources/accounts_local_datasource.dart';
import 'package:worknotes/src/features/accounts/domain/entities/account.dart';
import 'package:worknotes/src/features/accounts/domain/repositories/account_repository.dart';

class LocalAccountRepository extends AccountRepository {
  final AccountsLocalDataSource dataSource;

  LocalAccountRepository(this.dataSource);

  @override
  Future<Either<Failure, Account>> add(Account item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Account> findById(ObjectId objectId) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<Account> findByName(String name) {
    // TODO: implement findByName
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Account>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Account>> remove(Account item) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> update(int index, Account item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
