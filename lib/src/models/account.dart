import 'package:objectbox/objectbox.dart';

typedef AccountName = String;
typedef AccountKey = String;
typedef AccountSecret = String;

@Entity()
class Account {
  int id;

  @Unique()
  final AccountName name;
  final AccountKey key;
  final AccountSecret secret;

  Account({
    this.id = 0,
    required this.name,
    required this.key,
    required this.secret,
  });
}
