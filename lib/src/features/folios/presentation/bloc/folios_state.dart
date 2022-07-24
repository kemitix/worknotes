import 'package:equatable/equatable.dart';

import '../../domain/entities/folio.dart';

class FoliosState extends Equatable {
  final List<Folio> folios;

  const FoliosState(this.folios);

  @override
  List<Object?> get props => [folios];
}
