import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/models/accounts_model.dart';
import 'package:worknotes/settings/account_edit_fields.dart';

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
            AccountEditFields(
              name: nameController,
              apiKey: keyController,
              apiSecret: secretController,
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
