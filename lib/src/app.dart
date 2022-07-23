import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'client/client.dart';
import 'features/accounts/account_edit.dart';
import 'features/accounts/account_list.dart';
import 'features/accounts/data/repositories/in_memory_account_repository.dart';
import 'features/accounts/data/repositories/in_memory_folio_repository.dart';
import 'features/accounts/data/repositories/in_memory_workspace_repository.dart';
import 'features/accounts/domain/repositories/account_repository.dart';
import 'features/accounts/domain/repositories/folio_repository.dart';
import 'features/accounts/domain/repositories/workspace_repository.dart';
import 'features/folios/folio_list.dart';
import 'features/workspace/workspace_add.dart';
import 'features/workspace/workspace_list.dart';
import 'settings/app_settings.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => accountRepository()),
          ChangeNotifierProvider(create: (_) => workspaceRepository()),
          ChangeNotifierProvider(create: (_) => folioRepository()),
          Provider<Client>(create: (_) => ClientTrello()),
        ],
        child: MaterialApp(
          title: 'WorkNotes',
          theme: ThemeData(
            primarySwatch: Colors.lightGreen,
          ),
          home: const WorkspaceList(title: 'WorkNotes'),
          routes: <String, WidgetBuilder>{
            AppSettings.route: (_) => const AppSettings(),
            AccountList.route: (_) => const AccountList(),
            AccountEdit.routeAdd: (_) =>
                const AccountEdit(mode: AccountEditMode.Add),
            AccountEdit.routeEdit: (_) =>
                const AccountEdit(mode: AccountEditMode.Edit),
            WorkspaceAdd.route: (_) => const WorkspaceAdd(),
            FolioList.route: (_) => const FolioList(),
          },
        ));
  }

  AccountRepository accountRepository() => InMemoryAccountRepository();

  WorkspaceRepository workspaceRepository() => InMemoryWorkspaceRepository();

  FolioRepository folioRepository() => InMemoryFolioRepository();
}
