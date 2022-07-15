import 'package:flutter/material.dart';

import 'account_add.dart';
import 'accounts.dart';
import 'work_notes_settings.dart';
import 'workspace_add.dart';
import 'workspace_list.dart';

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
        '/settings': (BuildContext context) => WorkNotesSettings(),
        '/settings/accounts': (BuildContext context) => Accounts(),
        '/settings/accounts/add': (BuildContext context) => AccountAdd(),
        '/workspace/add': (BuildContext context) => WorkspaceAdd(),
      },
    );
  }
}

