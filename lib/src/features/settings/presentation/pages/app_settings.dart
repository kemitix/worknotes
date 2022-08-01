import 'package:flutter/material.dart';

import '../../../../core/widgets/navigation_list_tile.dart';
import '../../../accounts/presentation/pages/account_list.dart';

class AppSettings extends StatelessWidget {
  static const route = '/settings';
  static const navAccountsKey = Key('nav:accounts');

  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: const [
          NavigationListTile(
            key: navAccountsKey,
            title: 'Accounts',
            icon: Icons.manage_accounts,
            route: AccountList.route,
          ),
        ],
      ),
    );
  }
}
