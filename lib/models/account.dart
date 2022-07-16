typedef AccountName = String;
typedef AccountKey = String;
typedef AccountSecret = String;

class Account {
  final AccountName name;
  final AccountKey key;
  final AccountSecret secret;

  Account(this.name, this.key, this.secret);
}
