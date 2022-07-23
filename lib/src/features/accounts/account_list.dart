import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/src/features/accounts/domain/entities/account.dart';
import 'package:worknotes/src/features/accounts/domain/repositories/account_repository.dart';

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
      body: Consumer<AccountRepository>(
        builder: (context, accountRepo, child) => FutureBuilder<List<Account>>(
          future: accountRepo.getAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                List<Account> accounts = snapshot.data!;
                return ListView.separated(
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(accounts[index].name),
                        onTap: () => navigator.pushNamed(AccountEdit.routeEdit,
                            arguments: accounts[index]));
                  },
                  separatorBuilder: (a, b) => const Divider(),
                );
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
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
