import '../../../../core/in_memory_repository_mixin.dart';
import '../../domain/entities/workspace.dart';
import '../../domain/repositories/workspace_repository.dart';

class InMemoryWorkspaceRepository extends WorkspaceRepository
    with InMemoryRepository<Workspace> {}
