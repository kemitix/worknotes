import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'client/client.dart';
import 'features/accounts/accounts.dart';
import 'features/folios/presentation/bloc/folios_bloc.dart';
import 'features/folios/presentation/pages/folio_list.dart';
import 'features/settings/presentation/pages/app_settings.dart';
import 'features/workspaces/presentation/bloc/workspaces_bloc.dart';
import 'features/workspaces/presentation/pages/workspace_add.dart';
import 'features/workspaces/presentation/pages/workspace_list.dart';

class App extends StatelessWidget {
  final GetIt sl; // = GetIt.instance;

  const App({super.key, required this.sl});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<Client>(create: (_) => ClientTrello()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<AccountsBloc>()),
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
                  const AccountEdit(mode: AccountEditMode.add),
              AccountEdit.routeEdit: (_) =>
                  const AccountEdit(mode: AccountEditMode.edit),
              WorkspaceAdd.route: (_) => const WorkspaceAdd(),
              FolioList.route: (_) => const FolioList(),
            },
          ),
        ));
  }
}
