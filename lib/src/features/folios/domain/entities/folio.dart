import 'package:objectid/objectid.dart';

class Folio {
  final ObjectId id;
  final String name;
  final ObjectId workspaceId;
  final String? trelloListId;

  Folio({
    required this.id,
    required this.workspaceId,
    required this.name,
    this.trelloListId,
  });
}
