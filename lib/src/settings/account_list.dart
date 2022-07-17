import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';
import '../models/accounts_model.dart';
import 'edit_account_args.dart';

class AccountList extends StatelessWidget {
  const AccountList({super.key});

  void _addAccount(BuildContext context) {
    Navigator.pushNamed(context, '/settings/accounts/add');
  }

  void _editAccount(BuildContext context, Account account) {
    Navigator.pushNamed(context, '/settings/accounts/edit',
        arguments: EditAccountArgs(account));
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
              onTap: () => _editAccount(context, accounts.accounts[index]),
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
