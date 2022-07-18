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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspaces'),
      ),
      drawer: const WorkspaceDrawer(),
      body: Consumer<Storage<Workspace>>(
        builder: (context, workspaces, child) {
          return ListView.separated(
            itemCount: workspaces.items.length,
            itemBuilder: (BuildContext context, int index) {
              var workspaceItems = workspaces.items;
              return ListTile(
                title: Text(workspaceItems[index].name),
                //onTap: ,
              );
            },
            separatorBuilder: (a, b) => Divider(),
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
