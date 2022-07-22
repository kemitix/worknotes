import 'package:flutter/material.dart';

import '../features/accounts/account_list.dart';
import '../widgets/navigation_list_tile.dart';

class AppSettings extends StatefulWidget {
  static const route = '/settings';

  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: const [
          NavigationListTile(
            title: 'Accounts',
            icon: Icons.manage_accounts,
            route: AccountList.route,
          ),
        ],
      ),
    );
  }
}
