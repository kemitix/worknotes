import 'package:equatable/equatable.dart';
import 'package:objectid/objectid.dart';

import '../../../../core/has_id_name.dart';

class Account extends Equatable with HasIdName {
  final ObjectId id;
  final String type;
  final String name;
  final String key;
  final String secret;

  Account({
    required this.id,
    required this.type,
    required this.name,
    required this.key,
    required this.secret,
  });

  @override
  List<Object?> get props => [id, type, name, key, secret];
}
