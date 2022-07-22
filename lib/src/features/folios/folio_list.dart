import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/storage.dart';
import '../workspace/workspace.dart';
import 'folio.dart';

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
