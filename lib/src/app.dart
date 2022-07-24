import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/src/features/folios/presentation/bloc/folios_bloc.dart';

import 'client/client.dart';
import 'features/accounts/presentation/bloc/accounts_bloc.dart';
import 'features/accounts/presentation/pages/account_edit.dart';
import 'features/accounts/presentation/pages/account_list.dart';
import 'features/folios/presentation/pages/folio_list.dart';
import 'features/settings/presentation/pages/app_settings.dart';
import 'features/workspaces/presentation/bloc/workspaces_bloc.dart';
import 'features/workspaces/presentation/pages/workspace_add.dart';
import 'features/workspaces/presentation/pages/workspace_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<Client>(create: (_) => ClientTrello()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AccountsBloc()),
            BlocProvider(create: (context) => WorkspacesBloc()),
            BlocProvider(create: (context) => FoliosBloc())
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
          ),
        ));
  }
}
