import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/src/widgets/labelled_text_form_field.dart';

import '../../models/storage.dart';
import 'account.dart';

enum AccountEditMode { Add, Edit }

class AccountEdit extends StatefulWidget {
  static const routeAdd = '/settings/accounts/add';
  static const routeEdit = '/settings/accounts/edit';
  final AccountEditMode mode;

  const AccountEdit({super.key, required this.mode});

  String get appBar {
    switch (mode) {
      case AccountEditMode.Add:
        return 'Add Account';
      case AccountEditMode.Edit:
        return 'Edit Account';
    }
  }

  String get saveButtonLabel {
    switch (mode) {
      case AccountEditMode.Add:
        return 'Add';
      case AccountEditMode.Edit:
        return 'Save';
    }
  }

  bool get isEditMode => mode == AccountEditMode.Edit;

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
    var accountId = 0;
    if (widget.isEditMode) {
      final account = ModalRoute.of(context)!.settings.arguments as Account;
      accountId = account.id;
      nameController.text = account.name;
      keyController.text = account.key;
      secretController.text = account.secret;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBar),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelledTextFormField(
              label: 'Account Name',
              hintText: 'Enter account name',
              controller: nameController,
              validator: validateNotEmpty('Please enter an account name'),
            ),
            LabelledTextFormField(
              label: 'API Key',
              hintText: 'Enter API Key',
              controller: keyController,
              validator: validateNotEmpty('Please enter an API Key'),
            ),
            LabelledTextFormField(
              label: 'API Secret',
              hintText: 'Enter API Secret',
              controller: secretController,
              validator: validateNotEmpty('Please enter an API Secret'),
            ),
            Consumer<Storage<Account>>(
              builder: (context, accounts, child) => Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      accounts.add(Account(
                        id: accountId,
                        type: 'trello',
                        name: nameController.text,
                        key: keyController.text,
                        secret: secretController.text,
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(widget.saveButtonLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? Function(String?) validateNotEmpty(String message) =>
      (String? value) {
        if (value == null || value.isEmpty) {
          return message;
        }
        return null;
      };
}