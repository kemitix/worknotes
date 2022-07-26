import 'package:objectid/objectid.dart';

import '../../domain/entities/account.dart';

// ignore: must_be_immutable
class AccountModel extends Account {
  AccountModel({
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
}
