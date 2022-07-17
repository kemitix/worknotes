import 'package:objectbox/objectbox.dart';

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
}
