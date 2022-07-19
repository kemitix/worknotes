import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/storage.dart';
import '../models/workspace.dart';
import 'workspace_drawer.dart';

class WorkspaceList extends StatefulWidget {
  const WorkspaceList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WorkspaceList> createState() => _WorkspaceListState();
}

class _WorkspaceListState extends State<WorkspaceList> {
  void _addWorkspace() {
    setState(() {
      Navigator.pushNamed(context, '/workspace/add');
    });
  }

  void _showWorkspaceMenu(
      int index, Workspace workspace, Storage<Workspace> workspaces) {
    showMenu(context: context, position: RelativeRect.fill, items: [
      PopupMenuItem(
          child: const Text('Open'),
          onTap: () {
            print('Open workspace ${workspace.name}');
          }),
      PopupMenuItem(
          child: const Text('Remove'),
          onTap: () {
            workspaces.remove(workspace);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Workspace removed: ${workspace.name}')));
          }),
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
                onSecondaryTap: () {
                  _showWorkspaceMenu(index, workspace, workspaces);
                },
                child: ListTile(
                  title: Text(workspace.name),
                  //onTap: // TODO open the workspace
                  onLongPress: () {
                    _showWorkspaceMenu(index, workspace, workspaces);
                  },
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
