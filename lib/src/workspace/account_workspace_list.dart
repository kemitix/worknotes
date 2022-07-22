// lists workspace available for selection in the account
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../client/client.dart';
import '../features/accounts/account.dart';
import '../models/storage.dart';
import '../models/workspace.dart';

class AccountWorkspaceList extends StatelessWidget {
  final Account account;

  const AccountWorkspaceList({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    var client = context.read<Client>();
    return FutureBuilder(
      future: client.openWorkspaces(account),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const LinearProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('error: ${snapshot.error}');
            }
            var availableWorkspaces = snapshot.data! as List<Workspace>;
            return Expanded(
              child: Consumer<Storage<Workspace>>(
                  builder: (context, workspaces, child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      var workspace = availableWorkspaces[index];
                      return ListTile(
                          title: Text(workspace.name),
                          onTap: () {
                            workspaces.add(workspace);
                            account.workspaces.add(workspace);
                            Navigator.pop(context);
                          });
                    },
                    separatorBuilder: (a, b) => const Divider(),
                    itemCount: availableWorkspaces.length);
              }),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
