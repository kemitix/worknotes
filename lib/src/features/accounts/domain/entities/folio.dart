import 'package:objectid/objectid.dart';

import '../../../../core/has_id_name.dart';

class Folio with HasIdName {
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
