// lists workspace available for selection in the account
import 'package:flutter/material.dart';
import 'package:worknotes/src/models/workspace.dart';

import '../models/account.dart';

class AccountWorkspaceList extends StatelessWidget {
  final Account account;

  const AccountWorkspaceList({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: account.openWorkspaces(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('error: ${snapshot.error}');
          }
          var workspaces = snapshot.data! as List<Workspace>;
          return Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  var workspace = workspaces[index];
                  return ListTile(
                    title: Text(workspace.name),
                    onTap: () {
                      _selectWorkspace(workspace);
                    },
                  );
                },
                separatorBuilder: (a, b) => const Divider(),
                itemCount: workspaces.length),
          );
          // return Text(
          //     'found ${boards.length} boards:\n${boards.map((e) => e.name).join('\n')}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _selectWorkspace(Workspace workspace) {
    //TODO store board
  }
}
