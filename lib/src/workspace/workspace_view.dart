import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/src/models/workspace.dart';

import '../models/folio.dart';
import '../models/storage.dart';

class WorkspaceView extends StatelessWidget {
  static const route = '/workspace/view';

  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final workspace = ModalRoute.of(context)!.settings.arguments as Workspace;
    return Scaffold(
      appBar: AppBar(
        title: Text(workspace.name),
      ),
      body: Consumer<Storage<Folio>>(
        builder: (context, folios, child) {
          final allFolios = folios.items;
          return ListView.separated(
            itemBuilder: (context, index) {
              final folio = allFolios[index];
              return GestureDetector(
                child: ListTile(
                  title: Text(folio.name),
                ),
              );
            },
            separatorBuilder: (a, b) => const Divider(),
            itemCount: allFolios.length,
          );
        },
      ),
    );
  }
}
