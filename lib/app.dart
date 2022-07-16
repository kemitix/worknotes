import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/models/accounts_model.dart';

import 'settings/account_add.dart';
import 'settings/account_list.dart';
import 'settings/app_settings.dart';
import 'workspace/workspace_add.dart';
import 'workspace/workspace_list.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AccountsModel(),
        child: MaterialApp(
          title: 'WorkNotes',
          theme: ThemeData(
            primarySwatch: Colors.lightGreen,
          ),
          home: const WorkspaceList(title: 'WorkNotes'),
          routes: <String, WidgetBuilder>{
            '/settings': (BuildContext context) => AppSettings(),
            '/settings/accounts': (BuildContext context) => AccountList(),
            '/settings/accounts/add': (BuildContext context) => AccountAdd(),
            '/workspace/add': (BuildContext context) => WorkspaceAdd(),
          },
        ));
  }
}
