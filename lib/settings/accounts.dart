import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/accounts_model.dart';

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
      body: Consumer<AccountsModel>(
        builder: (context, accounts, child) => ListView.separated(
          itemCount: accounts.accounts.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(accounts.accounts[index].name),
              //onTap: ,
            );
          },
          separatorBuilder: (a, b) => Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAccount(context),
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ),
    );
  }
}
