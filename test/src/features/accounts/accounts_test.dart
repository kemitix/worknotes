import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknotes/src/client/client.dart';
import 'package:worknotes/src/features/accounts/presentation/pages/account_edit.dart';
import 'package:worknotes/src/features/accounts/presentation/pages/account_list.dart';
import 'package:worknotes/src/features/settings/presentation/pages/app_settings.dart';
import 'package:worknotes/src/features/workspaces/presentation/pages/workspace_list.dart';
import 'package:worknotes/src/features/workspaces/presentation/widgets/workspaces_drawer.dart';
import 'package:worknotes/src/injection_container.dart' as di;
import 'package:flutter_test/flutter_test.dart';
import 'package:worknotes/src/app.dart';

void main() {
  late SharedPreferences sharedPreferences;
  Future<void> createWidget(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    final sl = await di.init(sharedPreferences: sharedPreferences);
    final client = ClientTrello();
    await tester.pumpWidget(MaterialApp(home: App(sl: sl, client: client)));
  }

  testWidgets('can add an account', (tester) async {
    // start
    await createWidget(tester);
    expect(find.byType(WorkspaceList), findsOneWidget);

    // open drawer
    tester.firstState<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();
    expect(find.byKey(WorkspacesDrawer.navSettingsKey), findsOneWidget);

    // open settings
    await tester.tap(find.byKey(WorkspacesDrawer.navSettingsKey));
    await tester.pumpAndSettle();
    expect(find.byType(WorkspaceList), findsNothing);
    expect(find.byType(AppSettings), findsOneWidget);

    // open accounts
    await tester.tap(find.byKey(AppSettings.navAccountsKey));
    await tester.pumpAndSettle();
    expect(find.byType(AppSettings), findsNothing);
    expect(find.byType(AccountList), findsOneWidget);

    await tester.pump(const Duration(seconds: 20));

    // there are no accounts
    expect(find.byType(ListTile), findsNothing);

    // click add account button
    await tester.tap(find.byKey(AccountList.addButtonKey));
    await tester.pumpAndSettle();
    expect(find.byType(AccountList), findsNothing);
    expect(find.byType(AccountEdit), findsOneWidget);

    // fill in form
    final accountName = lorem(paragraphs: 1, words: 2);
    final apiKey = lorem(paragraphs: 1, words: 1);
    final apiSecret = lorem(paragraphs: 1, words: 1);
    await tester.enterText(
        find.byKey(AccountEdit.accountNameInputKey), accountName);
    await tester.enterText(find.byKey(AccountEdit.apiKeyInputKey), apiKey);
    await tester.enterText(
        find.byKey(AccountEdit.apiSecretInputKey), apiSecret);

    // submit form
    await tester.tap(find.byKey(AccountEdit.submitButtonKey));
    await tester.pumpAndSettle();
    expect(find.byType(AccountEdit), findsNothing);
    expect(find.byType(AccountList), findsOneWidget);

    // account was saved
    final accounts = sharedPreferences.getStringList('accounts');
    expect(accounts, isNotNull);
    expect(
        accounts!.first,
        contains(
            '"type":"trello","name":"$accountName","key":"$apiKey","secret":"$apiSecret"}'));

    // return to account list
    // there is one account
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text(accountName), findsOneWidget);

    // click back (to settings)
    // click back (to workspace)
    // click add workspace
    // click accounts drop down
    // verify added account it listed
  });
}
