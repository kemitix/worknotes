import 'package:objectid/objectid.dart';
import 'package:trello_client/external/dio_client_factory.dart';
import 'package:trello_client/trello_sdk.dart';

import '../features/accounts/domain/entities/account.dart';
import '../features/accounts/domain/entities/folio.dart';
import '../features/accounts/domain/entities/workspace.dart';

abstract class Client {
  Future<List<Workspace>> openWorkspaces(Account account);

  Future<List<Folio>> openFolios(Workspace workspace, Account account);
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
                      id: ObjectId(),
                      accountId: account.id,
                      name: board.name,
                      trelloBoardId: board.id.value,
                    ))
                .toList(growable: false));
      default:
        throw Exception('Unknown account type: ${account.type}');
    }
  }

  @override
  Future<List<Folio>> openFolios(Workspace workspace, Account account) async {
    switch (account.type) {
      case 'trello':
        return _trelloClient(account)
            .board(BoardId(workspace.trelloBoardId!))
            .getLists(filter: ListFilter.open)
            .then((lists) => lists
                .map((TrelloList list) => Folio(
                      id: ObjectId(),
                      workspaceId: workspace.id,
                      name: list.name,
                      trelloListId: list.id.value,
                    ))
                .toList(growable: false));
      default:
        throw Exception('Unknown account type: ${account.type}');
    }
  }
}
