import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/src/client/client.dart';

import '../objectbox.g.dart';
import 'models/accounts_model.dart';
import 'settings/account_edit.dart';
import 'settings/account_list.dart';
import 'settings/app_settings.dart';
import 'workspace/workspace_add.dart';
import 'workspace/workspace_list.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Store _store;
  bool hasBeenInitialised = false;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      _store =
          Store(getObjectBoxModel(), directory: join(dir.path, 'worknotes'));
      setState(() {
        hasBeenInitialised = true;
      });
    });
  }

  @override
  void dispose() {
    _store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasBeenInitialised) {
      return ChangeNotifierProvider(
          create: (context) => AccountsModel(_store),
          child: MultiProvider(
              providers: [
                Provider<Client>(create: (_) => ClientTrello()),
              ],
              child: MaterialApp(
                title: 'WorkNotes',
                theme: ThemeData(
                  primarySwatch: Colors.lightGreen,
                ),
                home: const WorkspaceList(title: 'WorkNotes'),
                routes: <String, WidgetBuilder>{
                  '/settings': (BuildContext context) => const AppSettings(),
                  '/settings/accounts': (BuildContext context) =>
                      const AccountList(),
                  '/settings/accounts/add': (BuildContext context) =>
                      const AccountEdit(action: 'Add', buttonLabel: 'Add'),
                  '/settings/accounts/edit': (BuildContext context) =>
                      const AccountEdit(action: 'Edit', buttonLabel: 'Save'),
                  '/workspace/add': (BuildContext context) =>
                      const WorkspaceAdd(),
                },
              )));
    }
    return const Center(child: CircularProgressIndicator());
  }
}
