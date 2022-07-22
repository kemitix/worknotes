import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/storage.dart';
import 'workspace.dart';
import 'workspace_add.dart';
import 'workspace_view.dart';
import 'workspaces_drawer.dart';

class WorkspaceList extends StatefulWidget {
  static const route = '/';

  const WorkspaceList({super.key, required this.title});

  final String title;

  @override
  State<WorkspaceList> createState() => _WorkspaceListState();
}

class _WorkspaceListState extends State<WorkspaceList> {
  void _showMenu(BuildContext context, Workspace workspace,
          Storage<Workspace> workspaces) =>
      showMenu(context: context, position: RelativeRect.fill, items: [
        PopupMenuItem(
            child: const Text('Remove'),
            onTap: () {
              setState(() => workspaces.remove(workspace));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Workspace removed: ${workspace.name}')));
            }),
      ]);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspaces'),
      ),
      drawer: const WorkspacesDrawer(),
      body: Consumer<Storage<Workspace>>(
        builder: (context, workspaces, child) {
          final allWorkspaces = workspaces.items;
          return ListView.separated(
            itemCount: allWorkspaces.length,
            itemBuilder: (context, index) {
              final workspace = allWorkspaces[index];
              return GestureDetector(
                onSecondaryTap: () => _showMenu(context, workspace, workspaces),
                child: ListTile(
                  title: Text(workspace.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.menu_sharp),
                    onPressed: () => _showMenu(context, workspace, workspaces),
                  ),
                  onTap: () => navigator.pushNamed(WorkspaceView.route,
                      arguments: workspace),
                  onLongPress: () => _showMenu(context, workspace, workspaces),
                ),
              );
            },
            separatorBuilder: (a, b) => const Divider(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigator.pushNamed(WorkspaceAdd.route),
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
