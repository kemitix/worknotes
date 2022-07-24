import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknotes/src/core/error/not_found_error.dart';

import 'workspaces_event.dart';
import 'workspaces_state.dart';

class WorkspacesBloc extends Bloc<WorkspacesEvent, WorkspacesState> {
  WorkspacesBloc() : super(const WorkspacesState([])) {
    on<AddOrUpdateWorkspaceEvent>((event, emit) {
      if (state.workspaces
          .any((workspace) => workspace.id == event.workspace.id)) {
        // update
        emit(WorkspacesState([
          ...state.workspaces.map((workspace) =>
              workspace.id == event.workspace.id ? event.workspace : workspace)
        ]));
      } else {
        // insert
        emit(WorkspacesState([...state.workspaces, event.workspace]));
      }
    });
    on<RemoveWorkspaceEvent>((event, emit) {
      if (state.workspaces
          .any((workspace) => workspace.id == event.workspace.id)) {
        emit(WorkspacesState([
          ...state.workspaces
              .where((workspace) => workspace.id != event.workspace.id),
        ]));
      } else {
        addError(NotFoundError(), StackTrace.current);
      }
    });
  }
}
