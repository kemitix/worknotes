import 'package:equatable/equatable.dart';

import '../../domain/entities/folio.dart';

abstract class FoliosEvent extends Equatable {}

class AddOrUpdateFolioEvent extends FoliosEvent {
  final Folio folio;

  AddOrUpdateFolioEvent(this.folio);

  @override
  List<Object?> get props => [folio];
}

class RemoveFolioEvent extends FoliosEvent {
  final Folio folio;

  RemoveFolioEvent(this.folio);

  @override
  List<Object?> get props => [folio];
}
