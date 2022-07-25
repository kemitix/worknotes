import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectid/objectid.dart';
import 'package:worknotes/src/features/accounts/domain/entities/account.dart';
import 'package:worknotes/src/features/accounts/domain/repositories/account_repository.dart';
import 'package:worknotes/src/features/accounts/domain/usecases/remove_account.dart';

import 'add_account_test.mocks.dart';

@GenerateMocks([AccountRepository])
void main() {
  MockAccountRepository mockAccountRepository = MockAccountRepository();
  RemoveAccount usecase = RemoveAccount(mockAccountRepository);

  test('Should remove account from repository', () async {
    //given
    Account account = Account(
        id: ObjectId(),
        type: 'foo',
        name: 'name',
        key: 'key',
        secret: 'secret');
    when(mockAccountRepository.remove(account))
        .thenAnswer((_) async => right(account));
    //when
    final result = await usecase.call(account);
    //then
    expect(result, right(account));
    verify(mockAccountRepository.remove(account));
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
