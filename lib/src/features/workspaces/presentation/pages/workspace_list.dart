import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../folios/presentation/pages/folio_list.dart';
import '../../domain/entities/workspace.dart';
import '../bloc/workspaces_bloc.dart';
import '../bloc/workspaces_event.dart';
import '../bloc/workspaces_state.dart';
import '../widgets/workspaces_drawer.dart';
import 'workspace_add.dart';

class WorkspaceList extends StatelessWidget {
  static const route = '/';

  final String title;

  const WorkspaceList({super.key, required this.title});

  void _showMenu(BuildContext context, Workspace workspace) =>
      showMenu(context: context, position: RelativeRect.fill, items: [
        PopupMenuItem(
            child: const Text('Remove'),
            onTap: () {
              context.read<WorkspacesBloc>().add(WorkspaceRemoved(workspace));
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
      body: BlocBuilder<WorkspacesBloc, WorkspacesState>(
        builder: (context, state) {
          final workspaces = state.workspaces;
          return ListView.separated(
            itemCount: workspaces.length,
            itemBuilder: (context, index) {
              final workspace = workspaces[index];
              return GestureDetector(
                onSecondaryTap: () => _showMenu(context, workspace),
                child: ListTile(
                  title: Text(workspace.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.menu_sharp),
                    onPressed: () => _showMenu(context, workspace),
                  ),
                  onTap: () => navigator.pushNamed(FolioList.route,
                      arguments: workspace),
                  onLongPress: () => _showMenu(context, workspace),
                ),
              );
            },
            separatorBuilder: (a, b) => const Divider(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigator.pushNamed(WorkspaceAdd.route),
        tooltip: 'Add Workspace',
        child: const Icon(Icons.add),
      ),
    );
  }
}
