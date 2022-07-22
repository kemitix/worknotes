import 'package:objectbox/objectbox.dart';

import '../../models/has_id.dart';
import '../workspace/workspace.dart';

@Entity()
class Account with HasId {
  int id;

  final String type;
  @Unique()
  final String name;
  final String key;
  final String secret;

  @Backlink('account')
  final workspaces = ToMany<Workspace>();

  Account({
    this.id = 0,
    required this.type,
    required this.name,
    required this.key,
    required this.secret,
  });
}
