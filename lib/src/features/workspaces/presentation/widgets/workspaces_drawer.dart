import 'package:flutter/material.dart';

import '../../../../core/widgets/navigation_list_tile.dart';
import '../../../settings/presentation/pages/app_settings.dart';

class WorkspacesDrawer extends StatelessWidget {
  static const navSettingsKey = Key('nav:settings');

  const WorkspacesDrawer({super.key});

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
          NavigationListTile(
            key: navSettingsKey,
            icon: Icons.settings,
            title: 'Settings',
            route: AppSettings.route,
          ),
        ],
      ),
    );
  }
}
