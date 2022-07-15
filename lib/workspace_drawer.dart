import 'package:flutter/material.dart';

class WorkspaceDrawer extends StatelessWidget {
  WorkspaceDrawer({Key? key}) : super(key: key);

  void _openSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
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
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => _openSettings(context),
          ),
        ],
      ),
    );
  }

}