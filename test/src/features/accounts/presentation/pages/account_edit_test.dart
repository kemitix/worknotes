import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectid/objectid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknotes/src/features/accounts/accounts.dart';

import '../../../../widget_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final accountNameLabelFinder = find.byKey(const Key('label:Account Name'));
  final accountNameTextInputFinder =
      find.byKey(const Key('textInput:Account Name'));
  final apiKeyLabelFinder = find.byKey(const Key('label:API Key'));
  final apiKeyTextInputFinder = find.byKey(const Key('textInput:API Key'));
  final apiSecretLabelFinder = find.byKey(const Key('label:API Secret'));
  final apiSecretTextInputFinder =
      find.byKey(const Key('textInput:API Secret'));
  final submitButtonFinder = find.byKey(const Key('button:submit'));

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

  MaterialApp testWidget(AccountEditMode mode, {Account? account}) {
    return MaterialApp(
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
    ));
  }

  group('has expected elements', () {
    testWidgets('has one account name label element', (widgetTester) async {
      //when
      await widgetTester.pumpWidget(testWidget(AccountEditMode.add));
      //then
      expect(accountNameLabelFinder, findsOneWidget);
    });
    testWidgets('has one account name text field element',
        (widgetTester) async {
      //when
      await widgetTester.pumpWidget(testWidget(AccountEditMode.add));
      //then
      expect(accountNameTextInputFinder, findsOneWidget);
    });
    testWidgets('has one API Key label element', (widgetTester) async {
      //when
      await widgetTester.pumpWidget(testWidget(AccountEditMode.add));
      //then
      expect(apiKeyLabelFinder, findsOneWidget);
    });
    testWidgets('has one API Key text field element', (widgetTester) async {
      //when
      await widgetTester.pumpWidget(testWidget(AccountEditMode.add));
      //then
      expect(apiKeyTextInputFinder, findsOneWidget);
    });
    testWidgets('has one API Secret label element', (widgetTester) async {
      //when
      await widgetTester.pumpWidget(testWidget(AccountEditMode.add));
      //then
      expect(apiSecretLabelFinder, findsOneWidget);
    });
    testWidgets('has one API Secret text field element', (widgetTester) async {
      //when
      await widgetTester.pumpWidget(testWidget(AccountEditMode.add));
      //then
      expect(apiSecretTextInputFinder, findsOneWidget);
    });
    testWidgets('has one save button element', (widgetTester) async {
      //when
      await widgetTester.pumpWidget(testWidget(AccountEditMode.add));
      //then
      expect(submitButtonFinder, findsOneWidget);
    });
  });

  group('add mode', () {
    testWidgets('has expected labels', (widgetTester) async {
      //when
      await widgetTester.pumpWidget(testWidget(AccountEditMode.add));

      //then
      expect(find.text('Add Account'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });
    testWidgets('Add Account', (widgetTester) async {
      //when
      await widgetTester.pumpWidget(testWidget(AccountEditMode.add));
      await widgetTester.enterText(
          accountNameTextInputFinder, 'my-account-name');
      await widgetTester.enterText(apiKeyTextInputFinder, 'my-key');
      await widgetTester.enterText(apiSecretTextInputFinder, 'my-secret');
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
      await widgetTester
          .pumpWidget(testWidget(AccountEditMode.edit, account: account));

      //then
      expect(find.text('Edit Account'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });
    testWidgets('has values from account argument in fields',
        (widgetTester) async {
      //when
      await widgetTester
          .pumpWidget(testWidget(AccountEditMode.edit, account: account));

      //then
      expect(textFromTextFormField(widgetTester, accountNameTextInputFinder),
          account.name);
      expect(textFromTextFormField(widgetTester, apiKeyTextInputFinder),
          account.key);
      expect(textFromTextFormField(widgetTester, apiSecretTextInputFinder),
          account.secret);
    });
    testWidgets('saves updated Account', (widgetTester) async {
      //when
      await widgetTester
          .pumpWidget(testWidget(AccountEditMode.edit, account: account));
      await widgetTester.enterText(
          accountNameTextInputFinder, 'my-account-name');
      await widgetTester.enterText(apiKeyTextInputFinder, 'my-key');
      await widgetTester.enterText(apiSecretTextInputFinder, 'my-secret');
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
