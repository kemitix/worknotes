import 'package:objectbox/objectbox.dart';
import 'package:worknotes/src/models/has_id.dart';

import '../accounts/account.dart';

@Entity()
class Workspace with HasId {
  int id;

  final String name;
  final account = ToOne<Account>();
  final String? trelloBoardId;

  Workspace({
    this.id = 0,
    required this.name,
    this.trelloBoardId,
  });
}
