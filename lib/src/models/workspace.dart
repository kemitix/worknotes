import 'package:objectbox/objectbox.dart';
import 'package:worknotes/src/models/has_id.dart';

import 'account.dart';

@Entity()
class Workspace with HasId {
  int id;

  final String boardId;
  final String name;
  final account = ToOne<Account>();

  Workspace({
    this.id = 0,
    required this.boardId,
    required this.name,
  });
}
