import 'package:trello_client/external/dio_client_factory.dart';
import 'package:trello_client/trello_sdk.dart';

import '../features/accounts/account.dart';
import '../features/folios/folio.dart';
import '../features/workspace/workspace.dart';

abstract class Client {
  Future<List<Workspace>> openWorkspaces(Account account);

  Future<List<Folio>> openFolios(Workspace workspace);
}

class ClientTrello implements Client {
  TrelloClient _trelloClient(Account account) =>
      dioClientFactory(TrelloAuthentication.of(
          MemberId(account.name), account.key, account.secret));

  @override
  Future<List<Workspace>> openWorkspaces(Account account) {
    switch (account.type) {
      case 'trello':
        return _trelloClient(account)
            .member(MemberId(account.name))
            .getBoards(filter: MemberBoardFilter.open)
            .then((boards) => boards
                .map((TrelloBoard board) => Workspace(
                      name: board.name,
                      trelloBoardId: board.id.value,
                    ))
                .toList(growable: false));
      default:
        throw Exception('Unknown account type: ${account.type}');
    }
  }

  @override
  Future<List<Folio>> openFolios(Workspace workspace) async {
    Account account = workspace.account.target!;
    switch (account.type) {
      case 'trello':
        return _trelloClient(account)
            .board(BoardId(workspace.trelloBoardId!))
            .getLists(filter: ListFilter.open)
            .then((lists) => lists
                .map((TrelloList list) => Folio(
                      name: list.name,
                      trelloListId: list.id.value,
                    ))
                .toList(growable: false));
      default:
        throw Exception('Unknown account type: ${account.type}');
    }
  }
}
