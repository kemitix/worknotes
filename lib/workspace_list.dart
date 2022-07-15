import 'package:flutter/material.dart';
import 'package:worknotes/settings_drawer.dart';

class WorkspaceList extends StatefulWidget {
  const WorkspaceList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WorkspaceList> createState() => _WorkspaceListState();
}

class _WorkspaceListState extends State<WorkspaceList> {

  //TODO add field list of workspaces

  void _addWorkspace() {
    setState(() {
      Navigator.pushNamed(context, '/workspace/add');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workspaces : ${widget.title}'),
      ),
      drawer: SettingsDrawer(),
      body: ListView(
        children: [
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
