import 'package:objectbox/objectbox.dart';
import 'package:trello_client/external/dio_client_factory.dart'
    show dioClientFactory;
import 'package:trello_client/trello_sdk.dart'
    show
        MemberBoardFilter,
        MemberId,
        TrelloAuthentication,
        TrelloBoard,
        TrelloClient;
import 'package:worknotes/src/models/workspace.dart';

@Entity()
class Account {
  int id;

  @Unique()
  final String name;
  final String key;
  final String secret;

  Account({
    this.id = 0,
    required this.name,
    required this.key,
    required this.secret,
  });

  TrelloClient _trelloClient() =>
      dioClientFactory(TrelloAuthentication.of(MemberId(name), key, secret));

  Future<List<Workspace>> openWorkspaces() => _trelloClient()
      .member(MemberId(name))
      .getBoards(filter: MemberBoardFilter.open)
      .then((boards) => boards
          .map((TrelloBoard board) => Workspace(
              accountId: id, boardId: board.id.value, name: board.name))
          .toList(growable: false));
}
