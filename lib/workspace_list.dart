import 'package:flutter/material.dart';
import 'package:worknotes/workspace_drawer.dart';

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
      drawer: WorkspaceDrawer(),
      body: ListView(
        children: const [
          // List of Workspaces (i.e. Trello Boards) grouped by Account
          // ListTile(
          //   title: Text('foo'),
          //   subtitle: Text('bar'),
          //   onTap: _openWorkspace(),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWorkspace,
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
