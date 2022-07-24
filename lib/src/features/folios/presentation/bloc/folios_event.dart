import 'package:equatable/equatable.dart';

import '../../domain/entities/folio.dart';

abstract class FoliosEvent extends Equatable {}

class FolioAddedOrUpdated extends FoliosEvent {
  final Folio folio;

  FolioAddedOrUpdated(this.folio);

  @override
  List<Object?> get props => [folio];
}

class FolioRemoved extends FoliosEvent {
  final Folio folio;

  FolioRemoved(this.folio);

  @override
  List<Object?> get props => [folio];
}
