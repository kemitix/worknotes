import 'package:flutter/material.dart';
import 'package:worknotes/src/feature/accounts/account_list.dart';

class AppSettings extends StatefulWidget {
  static const route = '/settings';

  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  void _openAccountsList(BuildContext context) {
    setState(() {
      Navigator.pushNamed(context, AccountList.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.manage_accounts),
            title: const Text('Accounts'),
            onTap: () => _openAccountsList(context),
          )
        ],
      ),
    );
  }
}
