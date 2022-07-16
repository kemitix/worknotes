import 'package:flutter_test/flutter_test.dart';
import 'package:worknotes/models/account.dart';
import 'package:worknotes/models/accounts_model.dart';

void main() {
  group('When adding an Account', () {
    test('it is added', () {
      //given
      final account = Account('name', 'key', 'secret');
      final accounts = AccountsModel();
      //when
      accounts.add(account);
      //then
      expect(accounts.accounts, hasLength(1));
      expect(accounts.accounts, contains(account));
    });
    test('listeners are notified', () {
      //given
      final account = Account('name', 'key', 'secret');
      final accounts = AccountsModel();
      var called = false;
      accounts.addListener(() {
        called = true;
      });
      //when
      accounts.add(account);
      //then
      expect(called, true);
    });
  });
  group('When adding an Account with duplicate name', () {
    test('New Account replaces existing', () {
      //given
      final account1 = Account('name', 'key', 'secret');
      final account2 = Account('name', 'key2', 'secret2');
      final AccountsModel accounts = AccountsModel();
      accounts.add(account1);
      //when
      accounts.add(account2);
      //then
      expect(accounts.accounts, hasLength(1));
      expect(accounts.accounts, isNot(contains(account1)));
      expect(accounts.accounts, contains(account2));
    });
  });
  group('When removing an existing Account', () {
    test('Account is removed', () {
      //given
      final account = Account('name', 'key', 'secret');
      final accounts = AccountsModel();
      accounts.add(account);
      //when
      accounts.remove('name');
      //then
      expect(accounts.accounts, hasLength(0));
    });
  });
  group('When removing a missing Account', () {
    test('Model is unchanged', () {
      //given
      final account = Account('name', 'key', 'secret');
      final accounts = AccountsModel();
      accounts.add(account);
      //when
      accounts.remove('not-found');
      //then
      expect(accounts.accounts, hasLength(1));
      expect(accounts.accounts, contains(account));
    });
  });
}
