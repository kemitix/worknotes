import 'package:objectbox/objectbox.dart';

@Entity()
class Workspace {
  int id;

  final int accountId;
  final String boardId;
  final String name;

  Workspace({
    this.id = 0,
    required this.accountId,
    required this.boardId,
    required this.name,
  });
}
