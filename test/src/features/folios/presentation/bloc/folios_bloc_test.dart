import 'package:bloc_test/bloc_test.dart';
import 'package:objectid/objectid.dart';
import 'package:test/test.dart';
import 'package:worknotes/src/features/folios/domain/entities/folio.dart';
import 'package:worknotes/src/features/folios/presentation/bloc/folios_bloc.dart';
import 'package:worknotes/src/features/folios/presentation/bloc/folios_event.dart';
import 'package:worknotes/src/features/folios/presentation/bloc/folios_state.dart';

void main() {
  test('Initial state is empty', () {
    //given
    final bloc = FoliosBloc();
    //then
    expect(bloc.state.folios.isEmpty, isTrue);
  });
  late FoliosBloc foliosBloc;
  setUp(() {
    foliosBloc = FoliosBloc();
  });
  final objectIdAlpha = ObjectId();
  final objectIdBeta = ObjectId();
  final workspaceIdAlpha = ObjectId();
  final workspaceIdBeta = ObjectId();
  Folio folioAlphaV1 = Folio(
    id: objectIdAlpha,
    workspaceId: workspaceIdAlpha,
    name: 'name 1',
    trelloListId: 'list id 1',
  );
  Folio folioAlphaV2 = Folio(
    id: objectIdAlpha,
    workspaceId: workspaceIdAlpha,
    name: 'name 2',
    trelloListId: 'list id 2',
  );
  Folio folioBetaV1 = Folio(
    id: objectIdBeta,
    workspaceId: workspaceIdBeta,
    name: 'name 1',
    trelloListId: 'list id 1',
  );
  blocTest<FoliosBloc, FoliosState>(
    'Add folios',
    build: () => foliosBloc,
    seed: () => FoliosState([]),
    act: (bloc) {
      bloc.add(AddOrUpdateFolioEvent(folioAlphaV1));
      bloc.add(AddOrUpdateFolioEvent(folioBetaV1));
    },
    expect: () => [
      FoliosState([folioAlphaV1]),
      FoliosState([folioAlphaV1, folioBetaV1])
    ],
  );
  blocTest<FoliosBloc, FoliosState>(
    'Add an folio where id already exists is an update',
    build: () => foliosBloc,
    seed: () => FoliosState([folioAlphaV1]),
    act: (bloc) => bloc.add(AddOrUpdateFolioEvent(folioAlphaV2)),
    expect: () => [
      FoliosState([folioAlphaV2])
    ],
  );
  blocTest<FoliosBloc, FoliosState>(
    'Remove a folio',
    build: () => foliosBloc,
    seed: () => FoliosState([folioAlphaV1]),
    act: (bloc) => bloc.add(RemoveFolioEvent(folioAlphaV1)),
    expect: () => [FoliosState([])],
  );
  blocTest<FoliosBloc, FoliosState>(
    'Removing a folio that doesn\'t exist is ignored',
    build: () => foliosBloc,
    seed: () => FoliosState([folioAlphaV1]),
    act: (bloc) => bloc.add(RemoveFolioEvent(folioBetaV1)),
    expect: () => [], // no changes
  );
}
