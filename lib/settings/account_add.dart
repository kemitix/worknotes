import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/models/accounts_model.dart';

import '../models/account.dart';

class AccountAdd extends StatefulWidget {
  const AccountAdd({Key? key}) : super(key: key);

  @override
  State<AccountAdd> createState() => _AccountAddState();
}

class _AccountAddState extends State<AccountAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final keyController = TextEditingController();
  final secretController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Account'),
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
                      accounts.add(Account(name, key, secret));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
