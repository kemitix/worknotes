// lists workspace available for selection in the account
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/src/features/workspaces/presentation/bloc/workspaces_bloc.dart';
import 'package:worknotes/src/features/workspaces/presentation/bloc/workspaces_event.dart';

import '../../../../client/client.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../domain/entities/workspace.dart';

class WorkspacesInAccountList extends StatefulWidget {
  final Account account;

  const WorkspacesInAccountList({super.key, required this.account});

  @override
  State<WorkspacesInAccountList> createState() =>
      _WorkspacesInAccountListState();
}

class _WorkspacesInAccountListState extends State<WorkspacesInAccountList> {
  @override
  Widget build(BuildContext context) {
    var client = context.read<Client>();
    return FutureBuilder<List<Workspace>>(
      future: client.openWorkspaces(widget.account),
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
                              .add(AddOrUpdateWorkspaceEvent(workspace));
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
