// lists workspace available for selection in the account
import 'package:flutter/material.dart';

import '../models/account.dart';

class AccountWorkspaceList extends StatelessWidget {
  final Account account;

  const AccountWorkspaceList({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    //TODO get list of TrelloBoards
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.separated(
            itemBuilder: (context, index) {
              return const Text('foo');
            },
            separatorBuilder: (a, b) => const Divider(),
            itemCount: 2)
      ],
    );
  }
}
