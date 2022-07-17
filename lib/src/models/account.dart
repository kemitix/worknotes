import 'package:objectbox/objectbox.dart';
import 'package:worknotes/src/models/has_id.dart';

@Entity()
class Account with HasId {
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
}
