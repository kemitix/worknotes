import 'package:flutter/material.dart';

class Accounts extends StatelessWidget {
  
  void _addAccount(BuildContext context) {
    Navigator.pushNamed(context, '/settings/accounts/add');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAccount(context),
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ),
    );
  }
}