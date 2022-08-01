import 'dart:convert';

import 'package:objectid/objectid.dart';

import '../../domain/entities/account.dart';

class AccountModel extends Account {
  const AccountModel({
    required super.id,
    required super.type,
    required super.name,
    required super.key,
    required super.secret,
  });

  factory AccountModel.fromMap(Map<String, dynamic> json) => AccountModel(
        id: ObjectId.fromHexString(json['id']),
        type: json['type'],
        name: json['name'],
        key: json['key'],
        secret: json['secret'],
      );

  Map<String, dynamic> toMap() => {
        'id': id.hexString,
        'type': type,
        'name': name,
        'key': key,
        'secret': secret,
      };

  factory AccountModel.fromAccount(Account account) => AccountModel(
      id: account.id,
      type: account.type,
      name: account.name,
      key: account.key,
      secret: account.secret);

  Account toAccount() =>
      Account(id: id, type: type, name: name, key: key, secret: secret);

  factory AccountModel.fromJson(String json) =>
      AccountModel.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}
