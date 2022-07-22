import 'package:objectbox/objectbox.dart';
import 'package:worknotes/src/models/has_id.dart';

import '../workspace/workspace.dart';

@Entity()
class Folio with HasId {
  int id;

  final String name;
  final workspace = ToOne<Workspace>();

  Folio({this.id = 0, required this.name});
}
