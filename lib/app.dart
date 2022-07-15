import 'package:flutter/material.dart';

import 'settings/account_add.dart';
import 'settings/accounts.dart';
import 'settings/app_settings.dart';
import 'workspace/workspace_add.dart';
import 'workspace/workspace_list.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkNotes',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const WorkspaceList(title: 'WorkNotes'),
      routes: <String, WidgetBuilder>{
        '/settings': (BuildContext context) => AppSettings(),
        '/settings/accounts': (BuildContext context) => Accounts(),
        '/settings/accounts/add': (BuildContext context) => AccountAdd(),
        '/workspace/add': (BuildContext context) => WorkspaceAdd(),
      },
    );
  }
}

