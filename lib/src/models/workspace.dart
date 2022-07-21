import 'package:objectbox/objectbox.dart';
import 'package:worknotes/src/models/has_id.dart';

import '../feature/accounts/account.dart';

@Entity()
class Workspace with HasId {
  int id;

  final String name;
  final account = ToOne<Account>();

  Workspace({
    this.id = 0,
    required this.name,
  });
}
