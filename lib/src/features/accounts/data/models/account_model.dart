import '../../domain/entities/account.dart';

class AccountModel extends Account {
  AccountModel({
    required super.id,
    required super.type,
    required super.name,
    required super.key,
    required super.secret,
  });
}
