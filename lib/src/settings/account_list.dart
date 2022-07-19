import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/src/models/storage.dart';
import 'package:worknotes/src/settings/account_edit.dart';

import '../models/account.dart';

class AccountList extends StatelessWidget {
  static const route = '/settings/accounts';

  const AccountList({super.key});

  void _addAccount(BuildContext context) {
    Navigator.pushNamed(context, AccountEdit.routeAdd);
  }

  void _editAccount(BuildContext context, Account account) {
    Navigator.pushNamed(context, AccountEdit.routeEdit, arguments: account);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: Consumer<Storage<Account>>(
        builder: (context, accounts, child) => ListView.separated(
          itemCount: accounts.items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(accounts.items[index].name),
              onTap: () => _editAccount(context, accounts.items[index]),
            );
          },
          separatorBuilder: (a, b) => const Divider(),
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
