import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../objectbox.g.dart';
import 'client/client.dart';
import 'features/accounts/account.dart';
import 'features/accounts/account_edit.dart';
import 'features/accounts/account_list.dart';
import 'features/folios/folio.dart';
import 'features/folios/folio_list.dart';
import 'features/workspace/workspace.dart';
import 'features/workspace/workspace_add.dart';
import 'features/workspace/workspace_list.dart';
import 'models/storage.dart';
import 'settings/app_settings.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Store _store;
  bool hasBeenInitialised = false;

  Admin? _admin;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      _store =
          Store(getObjectBoxModel(), directory: join(dir.path, 'worknotes'));
      if (Admin.isAvailable()) {
        _admin = Admin(_store);
      }
      setState(() {
        hasBeenInitialised = true;
      });
    });
  }

  @override
  void dispose() {
    if (_admin != null) {
      _admin!.close();
    }
    _store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasBeenInitialised) {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => Storage<Account>(_store)),
            ChangeNotifierProvider(create: (_) => Storage<Workspace>(_store)),
            ChangeNotifierProvider(create: (_) => Storage<Folio>(_store)),
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
    return const Center(child: CircularProgressIndicator());
  }
}
