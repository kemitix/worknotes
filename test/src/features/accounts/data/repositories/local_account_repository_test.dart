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
  // account 1 - a simple account
  var objectId1 = ObjectId();
  AccountModel accountModel1 = AccountModel(
      id: objectId1, type: 'type', name: 'name1', key: 'key', secret: 'secret');
  Account account1 = Account(
      id: objectId1, type: 'type', name: 'name1', key: 'key', secret: 'secret');
  var account1Json =
      '{"id":"$objectId1","type":"type","name":"name1","key":"key","secret":"secret"}';
  // account 2 - another simple account
  var objectId2 = ObjectId();
  AccountModel accountModel2 = AccountModel(
      id: objectId2, type: 'type', name: 'name2', key: 'key', secret: 'secret');
  Account account2 = Account(
      id: objectId2, type: 'type', name: 'name2', key: 'key', secret: 'secret');
  var account2Json =
      '{"id":"$objectId2","type":"type","name":"name2","key":"key","secret":"secret"}';
  // account 3 - a distinct account with the same name as account 1
  var objectId3 = ObjectId();
  AccountModel accountModel3 = AccountModel(
      id: objectId3, type: 'type', name: 'name1', key: 'key', secret: 'secret');
  Account account3 = Account(
      id: objectId3, type: 'type', name: 'name1', key: 'key', secret: 'secret');
  var account3Json =
      '{"id":"$objectId3","type":"type","name":"name1","key":"key","secret":"secret"}';
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

  void verifyNeverSaves() =>
      verifyNever(sharedPreferences.setStringList('accounts', any));

  group('constructor', () {
    test('load two accounts', () async {
      //given
      givenStartingAccounts([accountModel1, accountModel2]);
      //when
      var repository = createRepository();
      //then
      await verifyContents(repository, [account1, account2]);
      verifyConstructorLoads();
      verifyNoMoreInteractions(sharedPreferences);
    });
    test('load duplicate accounts - only one survives', () async {
      //given
      givenStartingAccounts([accountModel1, accountModel2, accountModel1]);
      //when
      var repository = createRepository();
      //then
      await verifyContents(repository, [account1, account2]);
    });
    test('load duplicate account names - only one survives', () async {
      //given
      givenStartingAccounts([accountModel1, accountModel2, accountModel3]);
      //when
      var repository = createRepository();
      //then
      await verifyContents(repository, [account3, account2]);
    });
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
        test('does not save accounts', () async {
          //given
          var repository = createRepository();
          //when
          await repository.add(account1);
          //then
          verifyConstructorLoads();
          verifyNeverSaves();
          verifyNoMoreInteractions(sharedPreferences);
        });
      });
      group('when account with same name is already present', () {
        setUp(() => givenStartingAccounts([accountModel1, accountModel2]));
        test('does not add conflicting account', () async {
          //given
          var repository = createRepository();
          //when
          await repository.add(account3);
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
        test('does not save accounts', () async {
          //given
          var repository = createRepository();
          //when
          await repository.add(account1);
          //then
          verifyConstructorLoads();
          verifyNeverSaves();
          verifyNoMoreInteractions(sharedPreferences);
        });
      });
    });
    group('remove()', () {
      group('when not present', () {
        setUp(() => givenStartingAccounts([accountModel2]));
        test('does not remove anything', () async {
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
        test('does not save accounts', () async {
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
    group('update()', () {
      setUp(() => givenStartingAccounts([accountModel1, accountModel2]));
      group('with valid index', () {
        test('returns updated account', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.update(0, account3);
          //then
          expect(result.isRight(), isTrue);
          result.map((account) => expect(account, account3));
        });
        test('changes contents', () async {
          //given
          var repository = createRepository();
          //when
          await repository.update(0, account3);
          //then
          verifyContents(repository, [account3, account2]);
        });
        test('saves accounts', () async {
          //given
          var repository = createRepository();
          //when
          await repository.update(0, account3);
          //then
          verifyConstructorLoads();
          // account 3 replaced account 1
          verifySaves([account3Json, account2Json]);
          verifyNoMoreInteractions(sharedPreferences);
        });
      });
      group('with invalid index', () {
        test('returns not found failure', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.update(2, account3);
          //then
          expect(result.isRight(), isFalse);
          result.map((failure) => expect(failure, NotFoundError()));
        });
        test('does not change contents', () async {
          //given
          var repository = createRepository();
          //when
          await repository.update(2, account3);
          //then
          verifyContents(repository, [account1, account2]);
        });
        test('does not save accounts', () async {
          //given
          var repository = createRepository();
          //when
          await repository.update(2, account3);
          //then
          verifyConstructorLoads();
          verifyNeverSaves();
          verifyNoMoreInteractions(sharedPreferences);
        });
      });
      group('with duplicate account at another index', () {
        test('returns duplicate failure', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.update(0, account2);
          //then
          expect(result.isRight(), isFalse);
          result.map((failure) => expect(failure, DuplicateError()));
        });
        test('does not change contents', () async {
          //given
          var repository = createRepository();
          //when
          await repository.update(0, account2);
          //then
          verifyContents(repository, [account1, account2]);
        });
        test('does not save accounts', () async {
          //given
          var repository = createRepository();
          //when
          await repository.update(0, account2);
          //then
          verifyConstructorLoads();
          verifyNeverSaves();
          verifyNoMoreInteractions(sharedPreferences);
        });
      });
      group('with duplicate account name at another index', () {
        test('returns duplicate failure', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.update(1, account1);
          //then
          expect(result.isRight(), isFalse);
          result.map((failure) => expect(failure, DuplicateError()));
        });
        test('does not change contents', () async {
          //given
          var repository = createRepository();
          //when
          await repository.update(1, account1);
          //then
          verifyContents(repository, [account1, account2]);
        });
        test('does not save accounts', () async {
          //given
          var repository = createRepository();
          //when
          await repository.update(1, account1);
          //then
          verifyConstructorLoads();
          verifyNeverSaves();
          verifyNoMoreInteractions(sharedPreferences);
        });
      });
    });
    group('findById()', () {
      group('where id is present', () {
        setUp(() => givenStartingAccounts([accountModel1]));
        test('returns the account', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.findById(objectId1);
          //then
          expect(result.isRight(), isTrue);
          result.map((account) => expect(account, account1));
        });
      });
      group('where id is not present', () {
        setUp(() => givenStartingAccounts([accountModel2]));
        test('returns not found error', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.findById(objectId1);
          //then
          expect(result.isRight(), isFalse);
          result.map((failure) => expect(failure, NotFoundError()));
        });
      });
    });
    group('findByName()', () {
      group('where name is present', () {
        setUp(() => givenStartingAccounts([accountModel1]));
        test('returns the account', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.findByName('name1');
          //then
          expect(result.isRight(), isTrue);
          result.map((account) => expect(account, account1));
        });
      });
      group('where name is not present', () {
        setUp(() => givenStartingAccounts([accountModel2]));
        test('returns not found error', () async {
          //given
          var repository = createRepository();
          //when
          var result = await repository.findByName('name1');
          //then
          expect(result.isRight(), isFalse);
          result.map((failure) => expect(failure, NotFoundError()));
        });
      });
    });
  });
}
