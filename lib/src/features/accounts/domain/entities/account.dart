import 'package:equatable/equatable.dart';
import 'package:objectid/objectid.dart';

import '../../../../core/has_id_name.dart';

// ignore: must_be_immutable
class Account extends Equatable with HasIdName {
  final String type;
  final String key;
  final String secret;

  Account({
    required ObjectId id,
    required this.type,
    required String name,
    required this.key,
    required this.secret,
  }) {
    this.id = id;
    this.name = name;
  }

  @override
  List<Object?> get props => [id, type, name, key, secret];
}
