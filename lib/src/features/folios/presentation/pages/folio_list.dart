import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../workspaces/domain/entities/workspace.dart';
import '../bloc/folios_bloc.dart';
import '../bloc/folios_state.dart';

class FolioList extends StatelessWidget {
  static const route = '/folios';

  const FolioList({super.key});

  @override
  Widget build(BuildContext context) {
    final workspace = ModalRoute.of(context)!.settings.arguments as Workspace;
    return Scaffold(
      appBar: AppBar(
        title: Text(workspace.name),
      ),
      body: BlocBuilder<FoliosBloc, FoliosState>(
        builder: (context, state) {
          final folios = state.folios;
          return ListView.separated(
            itemCount: folios.length,
            itemBuilder: (context, index) {
              final folio = folios[index];
              return GestureDetector(
                child: ListTile(
                  title: Text(folio.name),
                ),
              );
            },
            separatorBuilder: (a, b) => const Divider(),
          );
        },
      ),
    );
  }
}
