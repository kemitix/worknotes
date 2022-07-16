import 'package:flutter/material.dart';
import 'package:worknotes/workspace/workspace_drawer.dart';

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
      // body: Consumer<WorkSpaceModel>(
      //   builder: (context, accounts, child) => ListView.separated(
      //     itemCount: accounts.accounts.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       print(
      //           'Updateing list tile ${index}: ${accounts.accounts[index].name}');
      //       return ListTile(
      //         title: Text(accounts.accounts[index].name),
      //         //onTap: ,
      //       );
      //     },
      //     separatorBuilder: (a, b) => Divider(),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWorkspace,
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
