import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/not_found_error.dart';
import 'folios_event.dart';
import 'folios_state.dart';

class FoliosBloc extends Bloc<FoliosEvent, FoliosState> {
  FoliosBloc() : super(const FoliosState([])) {
    on<AddOrUpdateFolioEvent>((event, emit) {
      if (state.folios.any((folio) => folio.id == event.folio.id)) {
        // update
        emit(FoliosState([
          ...state.folios
              .map((folio) => folio.id == event.folio.id ? event.folio : folio)
        ]));
      } else {
        // insert
        emit(FoliosState([...state.folios, event.folio]));
      }
    });
    on<RemoveFolioEvent>((event, emit) {
      if (state.folios.any((folio) => folio.id == event.folio.id)) {
        emit(FoliosState([
          ...state.folios.where((folio) => folio.id != event.folio.id),
        ]));
      } else {
        addError(NotFoundError(), StackTrace.current);
      }
    });
  }
}
