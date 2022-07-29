import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknotes/src/core/error/duplicate_record_error.dart';
import 'package:worknotes/src/core/error/not_found_error.dart';
import 'package:worknotes/src/features/accounts/accounts.dart';

import 'local_account_repository_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  var objectId1 = ObjectId();
  AccountModel accountModel1 = AccountModel(
      id: objectId1, type: 'type', name: 'name1', key: 'key', secret: 'secret');
  Account account1 = Account(
      id: objectId1, type: 'type', name: 'name1', key: 'key', secret: 'secret');
  var account1Json =
      '{"id":"$objectId1","type":"type","name":"name1","key":"key","secret":"secret"}';
  var objectId2 = ObjectId();
  AccountModel accountModel2 = AccountModel(
      id: objectId2, type: 'type', name: 'name2', key: 'key', secret: 'secret');
  Account account2 = Account(
      id: objectId2, type: 'type', name: 'name2', key: 'key', secret: 'secret');
  var account2Json =
      '{"id":"$objectId2","type":"type","name":"name2","key":"key","secret":"secret"}';
  late MockSharedPreferences sharedPreferences;
  late AccountsLocalDataSource dataSource;

  LocalAccountRepository createRepository() =>
      LocalAccountRepository(dataSource);
  setUp(() {
    sharedPreferences = MockSharedPreferences();
    dataSource = SharedPreferencesAccountsLocalDataSource(sharedPreferences);
  });

  void givenStartingAccounts(List<AccountModel> accountModels) {
    List<String> jsonList = accountModels
        .map((accountModel) => json.encode(accountModel.toMap()))
        .toList(growable: false);
    when(sharedPreferences.getStringList('accounts')).thenReturn(jsonList);
  }

  void givenSaveIsSuccessful() {
    when(sharedPreferences.setStringList('accounts', any))
        .thenAnswer((_) => Future.value(true));
  }

  void verifyConstructorLoads() {
    verify(sharedPreferences.getStringList('accounts'))
        .called(1); // constructor loads
  }

  void verifySaves(List<String> saves) {
    verify(sharedPreferences.setStringList('accounts', saves)).called(1);
  }

  Future<void> verifyContents(
      LocalAccountRepository repository, List<Account> accounts) async {
    (await repository.getAll()).map((contents) => expect(contents, accounts));
  }

  test('constructor', () async {
    //given
    givenStartingAccounts([accountModel1, accountModel2]);
    //when
    var repository = createRepository();
    //then
    await verifyContents(repository, [account1, account2]);
    verifyConstructorLoads();
    verifyNoMoreInteractions(sharedPreferences);
  });

  group('methods triggering a save', () {
    setUp(() => givenSaveIsSuccessful());

    group('save()', () {
      test('saves accounts', () async {
        //given
        givenStartingAccounts([accountModel1, accountModel2]);
        var repository = createRepository();
        //when
        repository.save();
        //then
        verifyConstructorLoads();
        verifySaves([account1Json, account2Json]);
        verifyNoMoreInteractions(sharedPreferences);
      });
    });

    group('add()', () {
      group('when not already present', () {
        setUp(() => givenStartingAccounts([accountModel1]));
        test('adds account', () async {
          //given
          var repository = createRepository();
          //when
          await repository.add(account2);
          //then
          await verifyContents(repository, [account1, account2]);
        });
        test('returns added account', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.add(account2);
          //then
          expect(result.isRight(), isTrue);
          result.map((account) => expect(account, account2));
        });
        test('saves account', () async {
          //given
          var repository = createRepository();
          //when
          await repository.add(account2);
          //then
          verifyConstructorLoads(); //constructor load
          verifySaves([account1Json, account2Json]);
          verifyNoMoreInteractions(sharedPreferences);
        });
      });
      group('when already present', () {
        setUp(() => givenStartingAccounts([accountModel1, accountModel2]));

        test('adds account', () async {
          //given
          var repository = createRepository();
          //when
          await repository.add(account1);
          //then
          await verifyContents(repository, [account1, account2]);
        });
        test('returns duplicate failure', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.add(account1);
          //then
          expect(result.isRight(), isFalse);
          result.map((failure) => expect(failure, DuplicateError()));
        });
        test('doesn\'t save accounts', () async {
          //given
          var repository = createRepository();
          //when
          await repository.add(account1);
          //then
          verifyConstructorLoads();
          verifyNever(sharedPreferences.setStringList('accounts', any));
          verifyNoMoreInteractions(sharedPreferences);
        });
      });
    });

    group('remove()', () {
      group('when not present', () {
        setUp(() => givenStartingAccounts([accountModel2]));
        test('doesn\'t remove anything', () async {
          //given
          var repository = createRepository();
          //when
          await repository.remove(account1);
          //then
          await verifyContents(repository, [account2]);
        });
        test('returns not found failure', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.remove(account1);
          //then
          expect(result.isRight(), isFalse);
          result.map((failure) => expect(failure, NotFoundError()));
        });
        test('doesn\'t save accounts', () async {
          //given
          var repository = createRepository();
          //when
          await repository.remove(account1);
          //then
          verifyConstructorLoads(); //constructor load
          verifyNoMoreInteractions(sharedPreferences);
        });
      });
      group('when present', () {
        setUp(() => givenStartingAccounts([accountModel2, accountModel1]));
        test('removes account', () async {
          //given
          var repository = createRepository();
          //when
          await repository.remove(account1);
          //then
          await verifyContents(repository, [account2]);
        });
        test('returns removed account', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.remove(account1);
          //then
          expect(result.isRight(), isTrue);
          result.map((account) => expect(account, account1));
        });
        test('saves accounts', () async {
          //given
          var repository = createRepository();
          //when
          await repository.remove(account1);
          //then
          verifyConstructorLoads(); //constructor load
          verifySaves([account2Json]);
          verifyNoMoreInteractions(sharedPreferences);
        });
      });
    });
  });
}
