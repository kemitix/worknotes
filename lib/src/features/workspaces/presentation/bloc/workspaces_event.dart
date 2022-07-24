import 'package:equatable/equatable.dart';

import '../../domain/entities/workspace.dart';

abstract class WorkspacesEvent extends Equatable {}

class AddOrUpdateWorkspaceEvent extends WorkspacesEvent {
  final Workspace workspace;

  AddOrUpdateWorkspaceEvent(this.workspace);

  @override
  List<Object?> get props => [workspace];
}

class RemoveWorkspaceEvent extends WorkspacesEvent {
  final Workspace workspace;

  RemoveWorkspaceEvent(this.workspace);

  @override
  List<Object?> get props => [workspace];
}
