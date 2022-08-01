import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknotes/src/features/accounts/presentation/bloc/accounts_bloc.dart';
import 'package:worknotes/src/features/accounts/presentation/bloc/accounts_state.dart';

import 'account_edit.dart';

class AccountList extends StatelessWidget {
  static const route = '/settings/accounts';

  static const addButtonKey = Key('button:add');

  const AccountList({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: BlocBuilder<AccountsBloc, AccountsState>(
        builder: (context, state) {
          final accounts = state.accounts;
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: addButtonKey,
        onPressed: () => navigator.pushNamed(AccountEdit.routeAdd),
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ),
    );
  }
}
