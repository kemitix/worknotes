import 'package:worknotes/src/core/in_memory_repository_mixin.dart';
import 'package:worknotes/src/features/folios/domain/entities/folio.dart';
import 'package:worknotes/src/features/folios/domain/repositories/folio_repository.dart';

class InMemoryFolioRepository extends FolioRepository
    with InMemoryRepository<Folio> {}
