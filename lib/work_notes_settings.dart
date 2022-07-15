import 'package:flutter/material.dart';

class WorkNotesSettings extends StatefulWidget {
  @override
  State<WorkNotesSettings> createState() => _WorkNotesSettingsState();
}

class _WorkNotesSettingsState extends State<WorkNotesSettings> {

  void _openAccountsList(BuildContext context) {
    Navigator.pushNamed(context, '/settings/accounts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Accounts'),
            onTap: () => _openAccountsList(context),
          )
        ],
      ),
    );
  }
}