// lists workspace available for selection in the account
import 'package:flutter/material.dart';
import 'package:trello_client/external/dio_client_factory.dart';
import 'package:trello_client/trello_sdk.dart'
    show MemberId, TrelloAuthentication, TrelloBoard, TrelloClient;

import '../models/account.dart';

class AccountWorkspaceList extends StatelessWidget {
  final Account account;

  const AccountWorkspaceList({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    var memberId = MemberId(account.name);
    final authentication =
        TrelloAuthentication.of(memberId, account.key, account.secret);
    var client = dioClientFactory(authentication);
    var memberClient = client.member(memberId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder(
          future: memberClient.getBoards(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('error: ${snapshot.error}');
              }
              var boards = snapshot.data! as List<TrelloBoard>;
              return Text(
                  'found ${boards.length} boards: ${boards.map((e) => e.name).join(', ')}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
