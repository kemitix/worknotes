import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknotes/src/features/accounts/data/datasources/accounts_local_datasource.dart';
import 'package:worknotes/src/features/accounts/data/models/account_model.dart';

import 'accounts_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('loadAccounts', () {
    test('loads accounts', () {
      //given
      AccountModel accountModel = AccountModel(
          id: ObjectId(),
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
      List<AccountModel> result = dataSource.loadAccounts();
      //then
      expect(result, [accountModel]);
      verify(sharedPreferences.getStringList('accounts')).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    });
  });

  group('saveAccounts', () {
    test('saves accounts', () {
      //given
      ObjectId objectId = ObjectId();
      AccountModel accountModel = AccountModel(
          id: objectId,
          type: 'type',
          name: 'name',
          key: 'key',
          secret: 'secret');
      MockSharedPreferences sharedPreferences = MockSharedPreferences();
      AccountsLocalDataSource dataSource =
          SharedPreferencesAccountsLocalDataSource(sharedPreferences);
      when(sharedPreferences.setStringList('accounts', any))
          .thenAnswer((_) => Future.value(true));
      //when
      dataSource.saveAccounts([accountModel]);
      //then
      verify(sharedPreferences.setStringList('accounts', [
        '{"id":"${objectId.toString()}","type":"type","name":"name","key":"key","secret":"secret"}'
      ]));
    });
  });
}
