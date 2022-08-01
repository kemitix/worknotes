import 'package:objectid/objectid.dart';

class Workspace {
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
