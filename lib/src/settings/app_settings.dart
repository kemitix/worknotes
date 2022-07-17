import 'package:flutter/material.dart';

class AppSettings extends StatefulWidget {
  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  void _openAccountsList(BuildContext context) {
    Navigator.pushNamed(context, '/settings/accounts');
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
            leading: Icon(Icons.manage_accounts),
            title: const Text('Accounts'),
            onTap: () => _openAccountsList(context),
          )
        ],
      ),
    );
  }
}
