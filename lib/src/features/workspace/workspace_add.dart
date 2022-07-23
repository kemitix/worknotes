import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../accounts/domain/entities/account.dart';
import '../accounts/domain/repositories/account_repository.dart';
import 'workspaces_in_account_list.dart';

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
          child: Consumer<AccountRepository>(
            builder: (context, accountRepo, child) {
              return FutureBuilder<List<Account>>(
                future: accountRepo.getAll(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      List<Account> accounts = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Account'),
                          DropdownButton(
                            hint: const Text('Select Account'),
                            value: _accountName,
                            items: accounts.map((account) {
                              return DropdownMenuItem(
                                value: account.name,
                                child: Text(account.name),
                              );
                            }).toList(),
                            onChanged: (String? value) =>
                                setState(() => _accountName = value),
                          ),
                          //TODO: replace the following with another FutureBuilder that calls accountRepo.findByName
                          //TODO: and move higher in the tree to be out of the existing FutureBuilder
                          (_accountName == null
                              ? const Text('No account selected')
                              : WorkspacesInAccountList(
                                  account: accounts.firstWhere((account) =>
                                      account.name == _accountName)))
                        ],
                      );
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
