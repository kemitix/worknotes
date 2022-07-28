import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknotes/src/features/accounts/accounts.dart';

import 'local_account_repository_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('constructor', () {
    test('loads accounts', () {
      //given
      var objectId = ObjectId();
      AccountModel accountModel = AccountModel(
          id: objectId,
          type: 'type',
          name: 'name',
          key: 'key',
          secret: 'secret');
      Account account = Account(
          id: objectId,
          type: 'type',
          name: 'name',
          key: 'key',
          secret: 'secret');
      List<String> jsonList = [json.encode(accountModel.toMap())];
      MockSharedPreferences sharedPreferences = MockSharedPreferences();
      when(sharedPreferences.getStringList('accounts')).thenReturn(jsonList);
      AccountsLocalDataSource dataSource =
          SharedPreferencesAccountsLocalDataSource(sharedPreferences);
      //when
      LocalAccountRepository repository = LocalAccountRepository(dataSource);
      //then
      expect(repository.items, [account]);
      verify(sharedPreferences.getStringList('accounts')).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    });
  });
}
