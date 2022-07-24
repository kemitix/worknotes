import 'package:bloc_test/bloc_test.dart';
import 'package:objectid/objectid.dart';
import 'package:test/test.dart';
import 'package:worknotes/src/features/workspaces/domain/entities/workspace.dart';
import 'package:worknotes/src/features/workspaces/presentation/bloc/workspaces_bloc.dart';
import 'package:worknotes/src/features/workspaces/presentation/bloc/workspaces_event.dart';
import 'package:worknotes/src/features/workspaces/presentation/bloc/workspaces_state.dart';

void main() {
  test('Initial state is empty', () {
    //given
    final bloc = WorkspacesBloc();
    //then
    expect(bloc.state.workspaces.isEmpty, isTrue);
  });
  late WorkspacesBloc workspacesBloc;
  setUp(() {
    workspacesBloc = WorkspacesBloc();
  });
  final objectIdAlpha = ObjectId();
  final objectIdBeta = ObjectId();
  final accountIdAlpha = ObjectId();
  final accountIdBeta = ObjectId();
  Workspace workspaceAlphaV1 = Workspace(
    id: objectIdAlpha,
    accountId: accountIdAlpha,
    name: 'name 1',
    trelloBoardId: 'board id 1',
  );
  Workspace workspaceAlphaV2 = Workspace(
    id: objectIdAlpha,
    accountId: accountIdAlpha,
    name: 'name 2',
    trelloBoardId: 'board id 2',
  );
  Workspace workspaceBetaV1 = Workspace(
    id: objectIdBeta,
    accountId: accountIdBeta,
    name: 'name 1',
    trelloBoardId: 'board id 1',
  );
  blocTest<WorkspacesBloc, WorkspacesState>(
    'Add workspaces',
    build: () => workspacesBloc,
    seed: () => WorkspacesState([]),
    act: (bloc) {
      bloc.add(WorkspaceAddedOrUpdated(workspaceAlphaV1));
      bloc.add(WorkspaceAddedOrUpdated(workspaceBetaV1));
    },
    expect: () => [
      WorkspacesState([workspaceAlphaV1]),
      WorkspacesState([workspaceAlphaV1, workspaceBetaV1])
    ],
  );
  blocTest<WorkspacesBloc, WorkspacesState>(
    'Add an workspace where id already exists is an update',
    build: () => workspacesBloc,
    seed: () => WorkspacesState([workspaceAlphaV1]),
    act: (bloc) => bloc.add(WorkspaceAddedOrUpdated(workspaceAlphaV2)),
    expect: () => [
      WorkspacesState([workspaceAlphaV2])
    ],
  );
  blocTest<WorkspacesBloc, WorkspacesState>(
    'Remove a workspace',
    build: () => workspacesBloc,
    seed: () => WorkspacesState([workspaceAlphaV1]),
    act: (bloc) => bloc.add(WorkspaceRemoved(workspaceAlphaV1)),
    expect: () => [WorkspacesState([])],
  );
  blocTest<WorkspacesBloc, WorkspacesState>(
    'Removing a workspace that doesn\'t exist is ignored',
    build: () => workspacesBloc,
    seed: () => WorkspacesState([workspaceAlphaV1]),
    act: (bloc) => bloc.add(WorkspaceRemoved(workspaceBetaV1)),
    expect: () => [], // no changes
  );
}
