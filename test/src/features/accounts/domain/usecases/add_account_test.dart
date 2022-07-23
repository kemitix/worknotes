import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectid/objectid.dart';
import 'package:worknotes/src/core/error/failure.dart';
import 'package:worknotes/src/features/accounts/data/repositories/in_memory_account_repository.dart';
import 'package:worknotes/src/features/accounts/domain/entities/account.dart';
import 'package:worknotes/src/features/accounts/domain/usecases/add_account.dart';

void main() {
  InMemoryAccountRepository accountRepository = InMemoryAccountRepository();
  AddAccount usecase = AddAccount(accountRepository);

  test('Should add account to repository', () async {
    //given
    Account account = Account(
        id: ObjectId(),
        type: 'foo',
        name: 'name',
        key: 'key',
        secret: 'secret');
    //when
    final Either<Failure, void> result =
        await usecase.execute(account: account);
    //then
    expect(result, right(account));
    expect(accountRepository.items.length, 1);
    expect(accountRepository.items[0], account);
  });
}
