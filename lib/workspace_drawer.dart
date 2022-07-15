import 'package:flutter/material.dart';

class WorkspaceDrawer extends StatelessWidget {
  const WorkspaceDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
            ),
            child: Text(
              'Workspaces',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}