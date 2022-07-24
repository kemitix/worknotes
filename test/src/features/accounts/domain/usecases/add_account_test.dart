import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectid/objectid.dart';
import 'package:worknotes/src/core/error/failure.dart';
import 'package:worknotes/src/features/accounts/domain/entities/account.dart';
import 'package:worknotes/src/features/accounts/domain/repositories/account_repository.dart';
import 'package:worknotes/src/features/accounts/domain/usecases/add_account.dart';

import 'add_account_test.mocks.dart';

@GenerateMocks([AccountRepository])
void main() {
  MockAccountRepository mockAccountRepository = MockAccountRepository();
  AddAccount usecase = AddAccount(mockAccountRepository);

  test('Should add account to repository', () async {
    //given
    Account account = Account(
        id: ObjectId(),
        type: 'foo',
        name: 'name',
        key: 'key',
        secret: 'secret');
    when(mockAccountRepository.add(account))
        .thenAnswer((_) async => right(account));
    //when
    final Either<Failure, void> result =
        await usecase.execute(account: account);
    //then
    expect(result, right(account));
    verify(mockAccountRepository.add(account));
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
