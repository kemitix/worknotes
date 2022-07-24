import 'package:equatable/equatable.dart';

import '../../domain/entities/workspace.dart';

class WorkspacesState extends Equatable {
  final List<Workspace> workspaces;

  const WorkspacesState(this.workspaces);

  @override
  List<Object?> get props => [workspaces];
}
