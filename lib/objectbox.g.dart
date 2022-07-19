// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'src/models/account.dart';
import 'src/models/folio.dart';
import 'src/models/workspace.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(2, 5477021638011867449),
      name: 'Workspace',
      lastPropertyId: const IdUid(5, 3655107911588319187),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7852148100150098382),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(4, 2990621413868976163),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3655107911588319187),
            name: 'accountId',
            type: 11,
            flags: 520,
            indexId: const IdUid(6, 2620157542894634856),
            relationTarget: 'Account')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(6, 6770593426214547282),
      name: 'Account',
      lastPropertyId: const IdUid(4, 6563638240618016014),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7949428036546894197),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7803358896923581678),
            name: 'name',
            type: 9,
            flags: 2080,
            indexId: const IdUid(5, 5121608396293703966)),
        ModelProperty(
            id: const IdUid(3, 2868815147838237778),
            name: 'key',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6563638240618016014),
            name: 'secret',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(
            name: 'workspaces', srcEntity: 'Workspace', srcField: 'account')
      ]),
  ModelEntity(
      id: const IdUid(7, 9039077696783827050),
      name: 'Folio',
      lastPropertyId: const IdUid(3, 5125415375983507720),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5809714612083056610),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2843443122813901510),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5125415375983507720),
            name: 'workspaceId',
            type: 11,
            flags: 520,
            indexId: const IdUid(7, 5605110732901394694),
            relationTarget: 'Workspace')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(7, 9039077696783827050),
      lastIndexId: const IdUid(7, 5605110732901394694),
      lastRelationId: const IdUid(1, 993116277638220482),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [
        1123412719115031610,
        6101554884561981560,
        8714724073785652005,
        5876535344751761414
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        1731377683870491661,
        1521210409647283494,
        4663880727515146553,
        771502534705805446,
        4386661307741691754,
        841603907587338166,
        5231731328655884864,
        4710061614021135145,
        8901381334710082500,
        7545526974936034922,
        1092023133236892626,
        5075288672002774897,
        2022454386783972839,
        2685187056895379388,
        2629523339932833768,
        6449956067506904207,
        4611986438835733102,
        9210377582473636777
      ],
      retiredRelationUids: const [993116277638220482],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Workspace: EntityDefinition<Workspace>(
        model: _entities[0],
        toOneRelations: (Workspace object) => [object.account],
        toManyRelations: (Workspace object) => {},
        getId: (Workspace object) => object.id,
        setId: (Workspace object, int id) {
          object.id = id;
        },
        objectToFB: (Workspace object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(3, nameOffset);
          fbb.addInt64(4, object.account.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Workspace(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''));
          object.account.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.account.attach(store);
          return object;
        }),
    Account: EntityDefinition<Account>(
        model: _entities[1],
        toOneRelations: (Account object) => [],
        toManyRelations: (Account object) => {
              RelInfo<Workspace>.toOneBacklink(
                      5, object.id, (Workspace srcObject) => srcObject.account):
                  object.workspaces
            },
        getId: (Account object) => object.id,
        setId: (Account object, int id) {
          object.id = id;
        },
        objectToFB: (Account object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final keyOffset = fbb.writeString(object.key);
          final secretOffset = fbb.writeString(object.secret);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, keyOffset);
          fbb.addOffset(3, secretOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Account(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              key: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              secret: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''));
          InternalToManyAccess.setRelInfo(
              object.workspaces,
              store,
              RelInfo<Workspace>.toOneBacklink(
                  5, object.id, (Workspace srcObject) => srcObject.account),
              store.box<Account>());
          return object;
        }),
    Folio: EntityDefinition<Folio>(
        model: _entities[2],
        toOneRelations: (Folio object) => [object.workspace],
        toManyRelations: (Folio object) => {},
        getId: (Folio object) => object.id,
        setId: (Folio object, int id) {
          object.id = id;
        },
        objectToFB: (Folio object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addInt64(2, object.workspace.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Folio(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''));
          object.workspace.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.workspace.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Workspace] entity fields to define ObjectBox queries.
class Workspace_ {
  /// see [Workspace.id]
  static final id = QueryIntegerProperty<Workspace>(_entities[0].properties[0]);

  /// see [Workspace.name]
  static final name =
      QueryStringProperty<Workspace>(_entities[0].properties[1]);

  /// see [Workspace.account]
  static final account =
      QueryRelationToOne<Workspace, Account>(_entities[0].properties[2]);
}

/// [Account] entity fields to define ObjectBox queries.
class Account_ {
  /// see [Account.id]
  static final id = QueryIntegerProperty<Account>(_entities[1].properties[0]);

  /// see [Account.name]
  static final name = QueryStringProperty<Account>(_entities[1].properties[1]);

  /// see [Account.key]
  static final key = QueryStringProperty<Account>(_entities[1].properties[2]);

  /// see [Account.secret]
  static final secret =
      QueryStringProperty<Account>(_entities[1].properties[3]);
}

/// [Folio] entity fields to define ObjectBox queries.
class Folio_ {
  /// see [Folio.id]
  static final id = QueryIntegerProperty<Folio>(_entities[2].properties[0]);

  /// see [Folio.name]
  static final name = QueryStringProperty<Folio>(_entities[2].properties[1]);

  /// see [Folio.workspace]
  static final workspace =
      QueryRelationToOne<Folio, Workspace>(_entities[2].properties[2]);
}
