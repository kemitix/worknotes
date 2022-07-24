// lists workspace available for selection in the account
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../client/client.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../domain/entities/workspace.dart';
import '../bloc/workspaces_bloc.dart';
import '../bloc/workspaces_event.dart';

class WorkspacesInAccountList extends StatelessWidget {
  final Account account;

  const WorkspacesInAccountList({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    var client = context.read<Client>();
    return FutureBuilder<List<Workspace>>(
      future: client.openWorkspaces(account),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const LinearProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('error: ${snapshot.error}');
            }
            List<Workspace> workspaces = snapshot.data!;
            return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    var workspace = workspaces[index];
                    return ListTile(
                        title: Text(workspace.name),
                        onTap: () {
                          context
                              .read<WorkspacesBloc>()
                              .add(WorkspaceAddedOrUpdated(workspace));
                          Navigator.pop(context);
                        });
                  },
                  separatorBuilder: (a, b) => const Divider(),
                  itemCount: workspaces.length),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
