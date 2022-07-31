import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknotes/src/features/accounts/accounts.dart';

import '../../../../widget_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final accountNameInputFinder = find.byKey(AccountEdit.accountNameInputKey);
  final apiKeyInputFinder = find.byKey(AccountEdit.apiKeyInputKey);
  final apiSecretInputFinder = find.byKey(AccountEdit.apiSecretInputKey);
  final submitButtonFinder = find.byKey(AccountEdit.submitButtonKey);

  late SharedPreferences preferences;
  late AccountsBloc accountsBloc;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
    final dataSource = SharedPreferencesAccountsLocalDataSource(preferences);
    final repository = LocalAccountRepository(dataSource);
    final addAccount = AddAccount(repository);
    final removeAccount = RemoveAccount(repository);
    final getAllAccounts = GetAllAccounts(repository);
    accountsBloc = AccountsBloc(
      accountRepository: repository,
      addAccount: addAccount,
      removeAccount: removeAccount,
      getAllAccounts: getAllAccounts,
    )..add(LoadAccounts());
    repository.load();
  });

  Future<void> testWidget(
    WidgetTester widgetTester,
    AccountEditMode mode, {
    Account? account,
  }) async {
    return widgetTester.pumpWidget(
      MaterialApp(
        home: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute<Widget>(
              settings: RouteSettings(arguments: account),
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => accountsBloc,
                      ),
                    ],
                    child: AccountEdit(mode: mode),
                  )),
        ),
      ),
    );
  }

  group('has expected elements', () {
    testWidgets('has one account name label element', (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.add);
      //then
      expect(find.byKey(AccountEdit.accountNameLabelKey), findsOneWidget);
    });
    testWidgets('has one account name text field element',
        (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.add);
      //then
      expect(accountNameInputFinder, findsOneWidget);
    });
    testWidgets('has one API Key label element', (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.add);
      //then
      expect(find.byKey(AccountEdit.apiKeyLabelKey), findsOneWidget);
    });
    testWidgets('has one API Key text field element', (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.add);
      //then
      expect(apiKeyInputFinder, findsOneWidget);
    });
    testWidgets('has one API Secret label element', (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.add);
      //then
      expect(find.byKey(AccountEdit.apiSecretLabelKey), findsOneWidget);
    });
    testWidgets('has one API Secret text field element', (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.add);
      //then
      expect(apiSecretInputFinder, findsOneWidget);
    });
    testWidgets('has one save button element', (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.add);
      //then
      expect(submitButtonFinder, findsOneWidget);
    });
  });

  group('add mode', () {
    testWidgets('has expected labels', (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.add);

      //then
      expect(find.text('Add Account'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });
    testWidgets('saves new account', (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.add);
      await widgetTester.enterText(accountNameInputFinder, 'my-account-name');
      await widgetTester.enterText(apiKeyInputFinder, 'my-key');
      await widgetTester.enterText(apiSecretInputFinder, 'my-secret');
      await widgetTester.tap(submitButtonFinder);
      await widgetTester.pump();

      //then
      expect(
          preferences.getStringList('accounts'),
          contains(
            stringContainsInOrder([
              '{"id":"',
              '","type":"trello","name":"my-account-name","key":"my-key","secret":"my-secret"}'
            ]),
          ));
    });
  });

  group('edit mode', () {
    final Account account = Account(
        id: ObjectId(),
        type: 'type',
        name: 'name',
        key: 'key',
        secret: 'secret');
    testWidgets('has expected labels', (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.edit, account: account);

      //then
      expect(find.text('Edit Account'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });
    testWidgets('fields have values from supplied account',
        (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.edit, account: account);

      //then
      expect(textFromTextFormField(widgetTester, accountNameInputFinder),
          account.name);
      expect(
          textFromTextFormField(widgetTester, apiKeyInputFinder), account.key);
      expect(textFromTextFormField(widgetTester, apiSecretInputFinder),
          account.secret);
    });
    testWidgets('saves updated Account', (widgetTester) async {
      //when
      await testWidget(widgetTester, AccountEditMode.edit, account: account);
      await widgetTester.enterText(accountNameInputFinder, 'my-account-name');
      await widgetTester.enterText(apiKeyInputFinder, 'my-key');
      await widgetTester.enterText(apiSecretInputFinder, 'my-secret');
      await widgetTester.tap(submitButtonFinder);
      await widgetTester.pump();

      //then
      expect(
          preferences.getStringList('accounts'),
          contains(
            stringContainsInOrder([
              '{"id":"',
              '","type":"trello","name":"my-account-name","key":"my-key","secret":"my-secret"}'
            ]),
          ));
    });
  });
}
