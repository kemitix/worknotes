import 'package:flutter/material.dart';

class WorkNotesSettings extends StatefulWidget {
  @override
  State<WorkNotesSettings> createState() => _WorkNotesSettingsState();
}

class _WorkNotesSettingsState extends State<WorkNotesSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),),
    );
  }
}