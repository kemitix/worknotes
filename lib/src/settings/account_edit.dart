import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';
import '../models/accounts_model.dart';
import 'edit_account_args.dart';

class AccountEdit extends StatefulWidget {
  final String action;
  final String buttonLabel;

  const AccountEdit(
      {super.key, required this.action, required this.buttonLabel});

  @override
  State<AccountEdit> createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final keyController = TextEditingController();
  final secretController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.action == 'Edit') {
      final args =
          ModalRoute.of(context)!.settings.arguments as EditAccountArgs;
      final account = args.account;
      nameController.text = account.name;
      keyController.text = account.key;
      secretController.text = account.secret;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.action} Account'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text('Account Name'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(hintText: 'Enter account name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an account name';
                  }
                  return null;
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text('API Key'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TextFormField(
                controller: keyController,
                decoration: const InputDecoration(hintText: 'Enter API Key'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an API key';
                  }
                  return null;
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text('API Secret'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TextFormField(
                controller: secretController,
                decoration: const InputDecoration(hintText: 'Enter API Secret'),
                obscureText: true,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an API secret';
                  }
                  return null;
                },
              ),
            ),
            Consumer<AccountsModel>(
              builder: (context, accounts, child) => Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final name = nameController.text;
                      final key = keyController.text;
                      final secret = secretController.text;
                      accounts.add(Account(
                        name: name,
                        key: key,
                        secret: secret,
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(widget.buttonLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}