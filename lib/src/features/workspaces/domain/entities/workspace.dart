import 'package:objectid/objectid.dart';
import 'package:worknotes/src/core/has_id_name.dart';

class Workspace with HasIdName {
  final String? trelloBoardId;
  final ObjectId accountId;

  Workspace({
    required ObjectId id,
    required String name,
    required this.accountId,
    this.trelloBoardId,
  }) {
    this.id = id;
    this.name = name;
  }
}
