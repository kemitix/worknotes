import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../folios/presentation/pages/folio_list.dart';
import '../../domain/entities/workspace.dart';
import '../../domain/repositories/workspace_repository.dart';
import '../widgets/workspaces_drawer.dart';
import 'workspace_add.dart';

class WorkspaceList extends StatefulWidget {
  static const route = '/';

  const WorkspaceList({super.key, required this.title});

  final String title;

  @override
  State<WorkspaceList> createState() => _WorkspaceListState();
}

class _WorkspaceListState extends State<WorkspaceList> {
  void _showMenu(BuildContext context, Workspace workspace,
          WorkspaceRepository workspaceRepo) =>
      showMenu(context: context, position: RelativeRect.fill, items: [
        PopupMenuItem(
            child: const Text('Remove'),
            onTap: () {
              workspaceRepo.remove(workspace);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Workspace removed: ${workspace.name}')));
            }),
      ]);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspaces'),
      ),
      drawer: const WorkspacesDrawer(),
      body: Consumer<WorkspaceRepository>(
        builder: (context, workspaceRepo, child) {
          return FutureBuilder<List<Workspace>>(
            future: workspaceRepo.getAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  List<Workspace> workspaces = snapshot.data!;
                  return ListView.separated(
                    itemCount: workspaces.length,
                    itemBuilder: (context, index) {
                      final workspace = workspaces[index];
                      return GestureDetector(
                        onSecondaryTap: () =>
                            _showMenu(context, workspace, workspaceRepo),
                        child: ListTile(
                          title: Text(workspace.name),
                          trailing: IconButton(
                            icon: const Icon(Icons.menu_sharp),
                            onPressed: () =>
                                _showMenu(context, workspace, workspaceRepo),
                          ),
                          onTap: () => navigator.pushNamed(FolioList.route,
                              arguments: workspace),
                          onLongPress: () =>
                              _showMenu(context, workspace, workspaceRepo),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigator.pushNamed(WorkspaceAdd.route),
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
