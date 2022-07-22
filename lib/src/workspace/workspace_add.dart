import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/accounts/account.dart';
import '../models/storage.dart';
import 'account_workspace_list.dart';

class WorkspaceAdd extends StatefulWidget {
  static const route = '/workspace/add';

  const WorkspaceAdd({Key? key}) : super(key: key);

  @override
  State<WorkspaceAdd> createState() => _WorkspaceAddState();
}

class _WorkspaceAddState extends State<WorkspaceAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _accountName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Workspace'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<Storage<Account>>(
            builder: (context, accounts, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Account'),
                  DropdownButton(
                    hint: const Text('Select Account'),
                    value: _accountName,
                    items: accounts.items.map((account) {
                      return DropdownMenuItem(
                        value: account.name,
                        child: Text(account.name),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _accountName = value;
                      });
                    },
                  ),
                  (_accountName == null
                      ? const Text('No account selected')
                      : AccountWorkspaceList(
                          account: accounts.items.firstWhere(
                              (account) => account.name == _accountName)))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
