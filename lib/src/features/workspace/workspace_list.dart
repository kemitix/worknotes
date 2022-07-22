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
  void _addWorkspace(BuildContext context) =>
      Navigator.pushNamed(context, WorkspaceAdd.route);

  void _openWorkspace(BuildContext context, Workspace workspace) =>
      Navigator.pushNamed(context, WorkspaceView.route, arguments: workspace);

  void _removeWorkspace(BuildContext context, Storage<Workspace> workspaces,
      Workspace workspace) {
    setState(() => workspaces.remove(workspace));
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Workspace removed: ${workspace.name}')));
  }

  void _showWorkspaceMenu(BuildContext context, Workspace workspace,
          Storage<Workspace> workspaces) =>
      showMenu(context: context, position: RelativeRect.fill, items: [
        PopupMenuItem(
            child: const Text('Remove'),
            onTap: () => _removeWorkspace(context, workspaces, workspace)),
      ]);

  @override
  Widget build(BuildContext context) {
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
                onSecondaryTap: () =>
                    _showWorkspaceMenu(context, workspace, workspaces),
                child: ListTile(
                  title: Text(workspace.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.menu_sharp),
                    onPressed: () =>
                        _showWorkspaceMenu(context, workspace, workspaces),
                  ),
                  onTap: () => _openWorkspace(context, workspace),
                  onLongPress: () =>
                      _showWorkspaceMenu(context, workspace, workspaces),
                ),
              );
            },
            separatorBuilder: (a, b) => const Divider(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addWorkspace(context),
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}