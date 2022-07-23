import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worknotes/src/features/folios/domain/repositories/folio_repository.dart';

import '../../../workspaces/domain/entities/workspace.dart';
import '../../domain/entities/folio.dart';

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
      body: Consumer<FolioRepository>(
        builder: (context, folioRepo, child) {
          return FutureBuilder<List<Folio>>(
            future: folioRepo.getAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  List<Folio> folios = snapshot.data!;
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
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
