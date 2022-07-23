import 'package:objectid/objectid.dart';
import 'package:worknotes/src/core/has_id_name.dart';

class Workspace with HasIdName {
  final ObjectId id;
  final String name;
  final String? trelloBoardId;
  final ObjectId accountId;

  Workspace({
    required this.id,
    required this.name,
    required this.accountId,
    this.trelloBoardId,
  });
}
