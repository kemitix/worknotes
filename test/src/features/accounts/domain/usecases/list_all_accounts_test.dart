import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectid/objectid.dart';
import 'package:worknotes/src/core/error/failure.dart';
import 'package:worknotes/src/features/accounts/domain/entities/account.dart';
import 'package:worknotes/src/features/accounts/domain/repositories/account_repository.dart';
import 'package:worknotes/src/features/accounts/domain/usecases/get_all_accounts.dart';

import 'list_all_accounts_test.mocks.dart';

@GenerateMocks([AccountRepository])
void main() {
  MockAccountRepository mockAccountRepository = MockAccountRepository();
  GetAllAccounts usecase = GetAllAccounts(mockAccountRepository);

  test('Should return all accounts from repository', () async {
    //given
    Account account = Account(
        id: ObjectId(),
        type: 'foo',
        name: 'name',
        key: 'key',
        secret: 'secret');
    when(mockAccountRepository.getAll())
        .thenAnswer((_) async => right([account]));
    //when
    final Either<Failure, List<Account>> result = await usecase.execute();
    //then
    expect(result.isRight(), isTrue);
    expect(result.getOrElse(() => []), [account]);
    verify(mockAccountRepository.getAll());
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
