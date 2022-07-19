import 'package:flutter/material.dart';
import 'package:worknotes/src/settings/app_settings.dart';

class WorkspacesDrawer extends StatelessWidget {
  const WorkspacesDrawer({super.key});

  void _openSettings(BuildContext context) {
    Navigator.pushNamed(context, AppSettings.route);
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
