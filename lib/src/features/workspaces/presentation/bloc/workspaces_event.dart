import 'package:equatable/equatable.dart';

import '../../domain/entities/workspace.dart';

abstract class WorkspacesEvent extends Equatable {}

class WorkspaceAddedOrUpdated extends WorkspacesEvent {
  final Workspace workspace;

  WorkspaceAddedOrUpdated(this.workspace);

  @override
  List<Object?> get props => [workspace];
}

class WorkspaceRemoved extends WorkspacesEvent {
  final Workspace workspace;

  WorkspaceRemoved(this.workspace);

  @override
  List<Object?> get props => [workspace];
}
