import 'package:trello_client/external/dio_client_factory.dart';
import 'package:trello_client/trello_sdk.dart';

import '../features/accounts/account.dart';
import '../models/workspace.dart';

abstract class Client {
  Future<List<Workspace>> openWorkspaces(Account account);
}

class ClientTrello implements Client {
  TrelloClient _trelloClient(Account account) =>
      dioClientFactory(TrelloAuthentication.of(
          MemberId(account.name), account.key, account.secret));

  Future<List<Workspace>> openWorkspaces(Account account) {
    switch (account.type) {
      case 'trello':
        return _trelloClient(account)
            .member(MemberId(account.name))
            .getBoards(filter: MemberBoardFilter.open)
            .then((boards) => boards
                .map((TrelloBoard board) => Workspace(name: board.name))
                .toList(growable: false));
      default:
        throw Exception('Unknown account type: ${account.type}');
    }
  }
}
