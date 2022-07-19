import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/src/workspace/workspace_add.dart';
import 'package:worknotes/src/workspace/workspace_view.dart';

import '../models/storage.dart';
import '../models/workspace.dart';
import 'workspace_drawer.dart';

class WorkspaceList extends StatefulWidget {
  static const route = '/';

  const WorkspaceList({super.key, required this.title});

  final String title;

  @override
  State<WorkspaceList> createState() => _WorkspaceListState();
}

class _WorkspaceListState extends State<WorkspaceList> {
  void _addWorkspace() {
    setState(() {
      Navigator.pushNamed(context, WorkspaceAdd.route);
    });
  }

  void _openWorkspace(Workspace workspace) {
    setState(() {
      Navigator.pushNamed(context, WorkspaceView.route, arguments: workspace);
    });
  }

  void _removeWorkspace(Storage<Workspace> workspaces, Workspace workspace) {
    workspaces.remove(workspace);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Workspace removed: ${workspace.name}')));
  }

  void _showWorkspaceMenu(Workspace workspace, Storage<Workspace> workspaces) {
    showMenu(context: context, position: RelativeRect.fill, items: [
      PopupMenuItem(
          child: const Text('Open'), onTap: () => _openWorkspace(workspace)),
      PopupMenuItem(
          child: const Text('Remove'),
          onTap: () => _removeWorkspace(workspaces, workspace)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspaces'),
      ),
      drawer: const WorkspaceDrawer(),
      body: Consumer<Storage<Workspace>>(
        builder: (context, workspaces, child) {
          final allWorkspaces = workspaces.items;
          return ListView.separated(
            itemCount: allWorkspaces.length,
            itemBuilder: (BuildContext context, int index) {
              final workspace = allWorkspaces[index];
              return GestureDetector(
                onSecondaryTap: () => _showWorkspaceMenu(workspace, workspaces),
                child: ListTile(
                  title: Text(workspace.name),
                  onTap: () => _openWorkspace(workspace),
                  onLongPress: () => _showWorkspaceMenu(workspace, workspaces),
                ),
              );
            },
            separatorBuilder: (a, b) => const Divider(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWorkspace,
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
