import 'package:objectbox/objectbox.dart';
import 'package:worknotes/src/models/has_id.dart';
import 'package:worknotes/src/models/workspace.dart';

@Entity()
class Account with HasId {
  int id;

  @Unique()
  final String name;
  final String key;
  final String secret;

  @Backlink('account')
  final workspaces = ToMany<Workspace>();

  Account({
    this.id = 0,
    required this.name,
    required this.key,
    required this.secret,
  });
}
