import 'package:objectid/objectid.dart';

import '../../../../core/has_id_name.dart';

class Folio with HasIdName {
  final ObjectId workspaceId;
  final String? trelloListId;

  Folio({
    required ObjectId id,
    required this.workspaceId,
    required String name,
    this.trelloListId,
  }) {
    this.id = id;
    this.name = name;
  }
}
