import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/models/accounts_model.dart';
import 'package:worknotes/settings/account_edit_fields.dart';
import 'package:worknotes/settings/edit_account_args.dart';

import '../models/account.dart';

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
