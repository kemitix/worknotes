// lists workspace available for selection in the account
import 'package:flutter/material.dart';

import '../models/account.dart';

class AccountWorkspaceList extends StatelessWidget {
  final Account account;

  const AccountWorkspaceList({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Text(account.name);
  }
}
