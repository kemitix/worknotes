import 'package:objectbox/objectbox.dart';
import 'package:worknotes/src/models/has_id.dart';

@Entity()
class Workspace with HasId {
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
