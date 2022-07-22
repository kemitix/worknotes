import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/storage.dart';
import 'account.dart';
import 'account_edit.dart';

class AccountList extends StatelessWidget {
  static const route = '/settings/accounts';

  const AccountList({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: Consumer<Storage<Account>>(
        builder: (context, accounts, child) => ListView.separated(
          itemCount: accounts.items.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(accounts.items[index].name),
                onTap: () => navigator.pushNamed(AccountEdit.routeEdit,
                    arguments: accounts.items[index]));
          },
          separatorBuilder: (a, b) => const Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigator.pushNamed(AccountEdit.routeAdd),
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ),
    );
  }
}
